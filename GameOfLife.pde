//Assume a square grid of equal column and row sizes.
//Assume each index of the grid has a cell present, but the cell's status is either dead or alive. 
//Assume each cell has a chosen % chance of being either alive when initially generated.
import java.util.*;
import java.util.Arrays;

//currentGrid used for displaying grid after it has been updated each iteration. 
Cell[][] currentGrid;
//Video scale used for changing the scale of the squares in relation to the canvas size
int videoScale = 26;

void setup(){
 size(800,800);   
 frameRate(6);
 
 currentGrid = createGrid();
 
 //enable this line and comment the above to show text 3x1 grid
 //currentGrid = createTestGrid();
  
 displayCurrentGrid(currentGrid);
}

void draw(){
  checkGrid(currentGrid);
}

//Creates test 3x1 grid
public static Cell[][] createTestGrid(){
  Cell[][] cellGrid = new Cell[30][30];
    for (int cols = 0; cols < cellGrid.length; cols++) { // cols
      for (int rows = 0; rows < cellGrid[cols].length; rows++) { // rows
      
       cellGrid[cols][rows] = new Cell(false);
      
        if(rows == 5){
          if(cols == 3 || cols == 4 || cols == 5){
             cellGrid[cols][rows].setAlive(true);
          }
        }
      }
    }
    return cellGrid;
}

//creates grid of chosen size and random number of dead and alive cells
public static Cell[][] createGrid() {
    //Edit below numbers to change grid size. Remember to alter videoScale to ensure all squares fit
    Cell[][] cellGrid = new Cell[30][30];
    
    //iterate over entire 2d array
    for (int cols = 0; cols < cellGrid.length; cols++) { // cols
      for (int rows = 0; rows < cellGrid[cols].length; rows++) { // rows
      
        Random r = new Random();
        //Adjust this number to reduce or increase the liklihood of an alive cell
        int aliveChance = r.nextInt(5);
        
        if(aliveChance == 1) {
          cellGrid[cols][rows] = new Cell(true);
        }else{
          cellGrid[cols][rows] = new Cell(false);
        }  
        
      }
    }
    return cellGrid;
  }
  
//Check the current grids cells against the game of life rules
public void checkGrid(Cell[][] grid){
  //Cannot iterate over the grid you're also checking, so create a new grid and iterate on that based on the old grids current state
  Cell[][] newGrid = new Cell[grid.length][grid[0].length];

  //Create new grid that is equal to old grid
  for(int i=0; i<grid.length; i++){
    for(int j=0; j<grid[i].length; j++){
      
       if(grid[i][j].isAlive()){
          newGrid[i][j] = new Cell(true); 
       }
       else{
         newGrid[i][j] = new Cell(false); 
       }
    }
  }
  
  for (int cols = 1; cols < grid.length-1; cols++) { // cols
      for (int rows = 1; rows < grid[cols].length-1; rows++) { // rows
          //Check current cell against nearby cells
         
          int nearbyAlive = 0;
          boolean currentCellAlive = false;
         
          currentCellAlive = grid[cols][rows].isAlive();
          
          //All indicies immediately surrounding the current cell
          for (int i = -1; i <= 1; i++) { // cols
            for (int j = -1; j <= 1; j++) { // rows
             
             //If the cell is alive, increse nearbyAlive
              if(grid[cols + i][rows + j].isAlive() == true){
                nearbyAlive++;
              }
            }   
        }  
        
        //If the current cell was alive, take one from nearbyAlive count as it was initially included when checking neighbours
        if(currentCellAlive == true){
          nearbyAlive = nearbyAlive - 1; 
        }
        
        if(nearbyAlive == 3 && grid[cols][rows].isAlive() == false){ // Creation
           newGrid[cols][rows].setAlive(true);
           System.out.println("Creation!");
        }
        else if(nearbyAlive > 3 && grid[cols][rows].isAlive() == true){ //Overpop
           newGrid[cols][rows].setAlive(false);
           System.out.println("Overpopulation");
        }
        else if(nearbyAlive == 2 || nearbyAlive == 3 && grid[cols][rows].isAlive() == true){ // Survival
           // do nothing
        }
        else if(nearbyAlive < 2 && grid[cols][rows].isAlive() == true){ // Underpop
           newGrid[cols][rows].setAlive(false);
           System.out.println("Underpop");
        }  
     }   
  }
  
  //Finally, set global currentGrid equal to the newly created grid
  for(int i=0; i<newGrid.length; i++){
    for(int j=0; j<newGrid[i].length; j++){
      currentGrid[i][j]=newGrid[i][j];
    }
  }
  
  displayCurrentGrid(newGrid);
}  
   
//Display current grid, using black squares for alive cells and white squares for dead cells
public void displayCurrentGrid(Cell[][] currentGrid){
  for (int i = 0; i < currentGrid.length; i++) {
      for (int j = 0; j < currentGrid[i].length; j++) {
              
        int x = i*videoScale;
        int y = j*videoScale;

        if(currentGrid[i][j].isAlive() == true){
          fill(0);
          stroke(0);
          rect(x, y, videoScale, videoScale);
        }
        else{
          fill(255);
          stroke(0);
          rect(x, y, videoScale, videoScale);
        }
      }
    }
}
