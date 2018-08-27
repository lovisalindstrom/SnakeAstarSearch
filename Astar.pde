//Grupp 11
//Lovisa Lindström 
//Ellinor Granlund

class Astar{
  ArrayList<Spot> openSet;
  ArrayList<Spot> closedSet;
  ArrayList<Spot> path;
  Spot start;
  Spot end;
  Spot current;
  boolean noSolution = false;
  boolean newPath = false;
  int wdth = width / COLS;
  int hght = height / ROWS;

  
  Spot[][] grid = new Spot[ROWS][COLS];
  
  public Astar(){
    this.start = null;
    this.end = null;
    openSet = new ArrayList<Spot>();
    closedSet = new ArrayList<Spot>();
    path = new ArrayList<Spot>();
    
  }
 
  public void createGrid() {
    System.out.println("Create grid");
    for(int i = 0; i < COLS; i++) {
      for(int j = 0; j < ROWS; j++) {
        System.out.println("Create grid " + i + " " + j);
        grid[i][j] = new Spot(i, j);
      }
    }
  }
  
  public void addNeighbors(){
     for(int i = 0; i < COLS; i++) {
      for(int j = 0; j < ROWS; j++) {
        System.out.println("Add neighbors " + i + " " + j);
        grid[i][j].addNeighbors(grid);
      }
    }
  }
  
  public void drawGrid(){
   for(int i = 0; i < COLS; i++){
     for(int j = 0; j < ROWS; j++){
       grid[i][j].show(color(70));
     }
   }
  }
  
  public void drawOpenSet(){
   for(int i = 0; i < openSet.size(); i++){
     openSet.get(i).show(color(0,255,0));
   }
  }
  
  public void drawClosedSet(){
   for(int i = 0; i < closedSet.size(); i++){
     closedSet.get(i).show(color(255,0,0));
   }
  }
  
  public void drawPath(){
   for(int i = 0; i < path.size(); i++){
     path.get(i).show(color(0,0,255));
   }
  }
  
  public float heuristic(Spot a, Spot b){
    //euclidian distance
    float dist = dist(a.x, a.y, b.x, b.y);
    return dist;
  }
  

 void setupSearch(){
   createGrid();
   addNeighbors();
   
   //start = grid[0][0];
   //end = grid[COLS-1][ROWS-1];
   
   //openSet.add(start);
 }
 
 void clearLists(){
   openSet.clear();
   closedSet.clear();
   path.clear();
 }
 
 //void setPath(Spot temp){
 //  path.add(temp);
 //  System.out.println("Add to path " + temp);
 //  while(temp.previous != null){
 //    System.out.println("Add to path " + temp.previous);
 //    path.add(temp.previous);
 //    temp = temp.previous;
 //  }
 //}
 
 void search(int startCol, int startRow, int endCol, int endRow){
   clearLists();
   start = grid[startCol][startRow];
   end = grid[endCol][endRow];
   System.out.println("StartNode " + start);
   System.out.println("EndNode " + end);
   openSet.add(start);
   
   while(!openSet.isEmpty()){
     //System.out.println("openSet: " + openSet);
     int lowestIndex = 0;
     for(int i = 0; i < openSet.size(); i++){
       if(openSet.get(i).f < openSet.get(lowestIndex).f){
         lowestIndex = i;
       }
     }
     current = openSet.get(lowestIndex);
     
     //Check if we're finished
     if(openSet.get(lowestIndex) == end){
       //find the path
       for(int i = 0; i < closedSet.size(); i++){
         path.add(closedSet.get(i));
         System.out.println("Add to path " + closedSet.get(i));
       }
       
       System.out.println("DONE");
       break;
     }
     //Best option moves from openSet to closedSet
     openSet.remove(current);
     closedSet.add(current);
     
     for(int i = 0; i < current.neighborsList.size(); i++){
       Spot neighbor = current.neighborsList.get(i);
       
       if(!closedSet.contains(neighbor) /* && !neighbor.wall*/){
         float tempG = current.g + 1;
         
         //Is this a better path?
         if(openSet.contains(neighbor)){
           if(tempG < neighbor.g){
             neighbor.g = tempG;
             newPath = true;
           }
         }else {
           neighbor.g = tempG;
           newPath = true;
           openSet.add(neighbor);
         }
         //Yes, it's a better path
         if(newPath == true){
           neighbor.h = heuristic(neighbor, end);
           neighbor.f = neighbor.g + neighbor.h;
           neighbor.previous = current;
         }
       }
     }
   }
   
 }
 
 
}
