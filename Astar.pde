//The open and closed set could be tree strucures instead to speed up search

class Astar{
  ArrayList<Spot> openSet;
  ArrayList<Spot> closedSet;
  ArrayList<Spot> path;
  Spot start;
  Spot end;
  Spot current;
  //boolean noSolution = false;
  boolean newPath = false;
  int wdth = width / COLS;
  int hght = height / ROWS;

  
  Spot[][] grid = new Spot[ROWS][COLS];
  
  public Astar(){
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
    
    //float dist = abs(a.x-b.x) + abs(a.y-b.y);
    return dist;
  }
  

 void setupSearch(){
   createGrid();
   addNeighbors();
   
   //start = grid[0][0];
   //end = grid[COLS-1][ROWS-1];
   
   //openSet.add(start);
 }
 
 void search(Snake snake, Food food){
   openSet.clear();
   closedSet.clear();
   path.clear();
   start = grid[0][0];
   end = grid[food.col][food.row];
   System.out.println("StartNode " + start);
   System.out.println("EndNode " + end);
   openSet.add(start);
   
   while(openSet.size() > 0){
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
       Spot temp = current;
       path.add(temp);
       while(temp.previous != null){
         path.add(temp.previous);
         temp = temp.previous;
       }
       //noLoop();
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
   }//else{
   //  //no solution
   //  System.out.println("No solution");
   //  noLoop();
   //  return;
   //}
      
   background(255);
   
   //drawGrid();
   
   //drawClosedSet();
   
   //drawOpenSet();
   
   

   //Spot temp = current;
   //path.add(temp);
   //while(temp.previous != null){
   //  path.add(temp.previous);
   //  temp = temp.previous;
   //}

   drawPath(); 
   
 
 }
 
 
}
