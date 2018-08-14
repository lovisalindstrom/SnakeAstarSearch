//The open and closed set could be tree strucures instead to speed up search

class Astar{
  ArrayList<Spot> openSet = new ArrayList<Spot>();
  ArrayList<Spot> closedSet = new ArrayList<Spot>();
  ArrayList<Spot> path = new ArrayList<Spot>();
  Spot start;
  Spot end;
  Spot current;
  //boolean noSolution = false;
  boolean newPath = false;
  int wdth = width / COLS;
  int hght = height / ROWS;

  
  Spot[][] grid = new Spot[ROWS][COLS];
  
 
  public void createGrid() {
    for(int i = 0; i < COLS; i++) {
      for(int j = 0; j < ROWS; j++) {
        System.out.println(i + " " + j);
        grid[i][j] = new Spot(i, j);
      }
    }
  }
  
  public void addNeighbors(){
     for(int i = 0; i < COLS; i++) {
      for(int j = 0; j < ROWS; j++) {
        System.out.println(i + " " + j);
        grid[i][j].addNeighbors(grid);
      }
    }
  }
  
  public void drawGrid(){
   for(int i = 0; i < COLS; i++){
     for(int j = 0; j < ROWS; j++){
       grid[i][j].show(color(255));
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
   size(600, 600);
   System.out.println("Create grid");
   createGrid();
   addNeighbors();
   drawGrid();
   //start = grid[0][0];
   //end = grid[COLS-1][ROWS-1];
   //start.wall = false;
   //end.wall = false;
   
   //openSet.add(start);
 }
 
 void search(Snake snake, Food food){
   //start = grid[snake.x][snake.y];
   //end = grid[(int)food.location.x][(int)food.location.y];
   start = new Spot(snake.x, snake.y);
   end = new Spot((int)food.location.x,(int)food.location.y);
   openSet.add(start);
   
   if(openSet.size() > 0){
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
       noLoop();
       System.out.println("DONE");
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
   }else{
     //no solution
     System.out.println("No solution");
     noLoop();
     return;
   }
      
   background(255);
   
   drawGrid();
   
   drawClosedSet();
   
   drawOpenSet();
   
   

   //Spot temp = current;
   //path.add(temp);
   //while(temp.previous != null){
   //  path.add(temp.previous);
   //  temp = temp.previous;
   //}

   drawPath(); 
   
      
   
   //noFill();
   //stroke(255);
   //beginShape();
   //for(int i = 0; i < path.size(); i++){
   //  vertex((path.get(i).x*wdth), (path.get(i).y*hght));
   //}
   //endShape();
 
 }
 
 
}
