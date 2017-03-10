

import de.bezier.guido.*;
public final static int NUM_COLS = 30;
public final static int NUM_ROWS = 16;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(600, 320);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int i = 0; i < buttons.length; i++)
        for (int j = 0; j < buttons[i].length; j++)
            buttons[i][j] = new MSButton(i, j);
    
    setBombs();
}
public void setBombs()
{
    //your code
    for (int k = 0; k < 99; k++)
    {
        int row = (int)(Math.random()*NUM_ROWS);
        int col = (int)(Math.random()*NUM_COLS);
        if (!bombs.contains(buttons[row][col])) 
            bombs.add(buttons[row][col]);
        else 
            k--;

        //System.out.println(bombs.size());
    }    
}
public void keyPressed()
{
    if(key == 'r')
        setup();
}
public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    for(int i = 0; i < bombs.size(); i++)
        if(bombs.get(i).isMarked() == false)
            return false;
    return true;
}
public void displayLosingMessage()
{
    //your code here
    
    for (int i =0; i < bombs.size (); i++) 
    {
        bombs.get(i).marked = false;
        bombs.get(i).clicked = true;
    }

    buttons[8][12].setLabel("L");
    buttons[8][13].setLabel("O");
    buttons[8][14].setLabel("S");
    buttons[8][15].setLabel("E");
    buttons[8][16].setLabel("R");
}
public void displayWinningMessage()
{
    //your code here
    buttons[8][12].setLabel("W");
    buttons[8][13].setLabel("I");
    buttons[8][14].setLabel("N");
    buttons[8][15].setLabel("N");
    buttons[8][16].setLabel("E");
    buttons[8][17].setLabel("R");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 600/NUM_COLS;
        height = 320/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(mouseButton == RIGHT)
            marked = !marked;
        else if(mouseButton == LEFT && !buttons[r][c].isMarked())
        {
            if(bombs.contains(this))
                displayLosingMessage();
            else if (countBombs(r,c) > 0)
                setLabel(new String() + countBombs(r,c));
            else
            {
                if(isValid(r-1,c) == true && buttons[r-1][c].isClicked() == false)
                    buttons[r-1][c].mousePressed();
                if(isValid(r-1,c-1) == true && buttons[r-1][c-1].isClicked() == false)
                    buttons[r-1][c-1].mousePressed();
                if(isValid(r,c-1) == true && buttons[r][c-1].isClicked() == false)
                    buttons[r][c-1].mousePressed();
                if(isValid(r+1,c-1) == true && buttons[r+1][c-1].isClicked() == false)
                    buttons[r+1][c-1].mousePressed();
                if(isValid(r+1,c) == true && buttons[r+1][c].isClicked() == false)
                    buttons[r+1][c].mousePressed();
                if(isValid(r+1,c+1) == true && buttons[r+1][c+1].isClicked() == false)
                    buttons[r+1][c+1].mousePressed();
                if(isValid(r,c+1) == true && buttons[r][c+1].isClicked() == false)
                    buttons[r][c+1].mousePressed();
                if(isValid(r-1,c+1) == true && buttons[r-1][c+1].isClicked() == false)
                    buttons[r-1][c+1].mousePressed();
            }
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r>=0 && r<NUM_ROWS && c>=0 && c<NUM_COLS)
            return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        if (isValid(r-1,c) == true && bombs.contains(buttons[row-1][col]))
            numBombs++;
        if (isValid(r-1,c-1) == true && bombs.contains(buttons[row-1][col-1]))
            numBombs++;
        if (isValid(r,c-1) == true && bombs.contains(buttons[row][col-1]))
            numBombs++;
        if (isValid(r+1,c-1) == true && bombs.contains(buttons[row+1][col-1]))
            numBombs++;
        if (isValid(r+1,c) == true && bombs.contains(buttons[row+1][col]))
            numBombs++;
        if (isValid(r+1,c+1) == true && bombs.contains(buttons[row+1][col+1]))
            numBombs++;
        if (isValid(r,c+1) == true && bombs.contains(buttons[row][col+1]))
            numBombs++;
        if (isValid(r-1,c+1) == true && bombs.contains(buttons[row-1][col+1]))
            numBombs++;
        return numBombs;
    }
}



