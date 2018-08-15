class Food{
  int col;
  int row;
  PVector location;
  
  public Food(PVector location, int col, int row){
    this.location = location;
    this.col = col;
    this.row = row;
  }
  
  void show(){
    fill(255, 0, 100);
    rect(location.x,location.y,scl,scl);
  }
}
