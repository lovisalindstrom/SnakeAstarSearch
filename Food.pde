//Grupp 11
//Lovisa Lindström 
//Ellinor Granlund

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
    fill(0, 100, 230);
    rect(location.x,location.y,scl,scl);
  }
}
