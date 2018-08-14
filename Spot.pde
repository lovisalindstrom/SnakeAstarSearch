class Spot {
  
  float f;
  float g;
  float h;
  float x; 
  float y;
  int wdth = width / COLS;
  int hght = height / ROWS;
  Spot previous;
  //boolean wall;
  
  ArrayList<Spot> neighborsList = new ArrayList<Spot>();
  
  public Spot(float i, float j) {
    this.x = i;
    this.y = j;
    this.f = 0;
    this.g = 0;
    this.h = 0;
    this.previous = null;
    //this.wall = false;
    //if(random(1) < 0.3){
    //  this.wall = true;
    //}
  }
  
  void addNeighbors(Spot[][] grid){
    int i = (int)this.x;
    int j = (int)this.y;
    if(i < COLS-1){
      neighborsList.add(grid[i+1][j]);
    }
    if(i > 0){
      neighborsList.add(grid[i-1][j]);
    }
    if(j < ROWS-1){
      neighborsList.add(grid[i][j+1]);
    }
    if(j > 0){
      neighborsList.add(grid[i][j-1]);
    }
    if(i > 0 && j > 0){
      neighborsList.add(grid[i-1][j-1]);
    }
    if(i < COLS-1 && j > 0){
      neighborsList.add(grid[i+1][j-1]);
    }
    if(i > 0 && j < ROWS-1){
      neighborsList.add(grid[i-1][j+1]);
    }
    if(i < COLS-1 && j < ROWS-1){
      neighborsList.add(grid[i+1][j+1]);
    }
  }
  
  public ArrayList<Spot> getNeighborsList(){
    return new ArrayList<Spot>(neighborsList);
  }
  
  void draw(color col){
    //System.out.println("Show spot");
    fill(col);
    //if(this.wall){
    //  fill(0);
    //}
    stroke(0);
    rect((this.x * wdth), (this.y * hght), wdth, hght);
    //System.out.println("x: " + (this.x * wdth) + " y: " + (this.y * hght) + " w: " + (wdth) + " h: " + (hght));
  }
  
  void show(color col){
    draw(col);
  }
}
