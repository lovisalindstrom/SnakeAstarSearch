class Food{

  PVector location;
  
  public Food(PVector location){
    this.location = location;
  }
  
  void show(){
    fill(255, 0, 100);
    rect(location.x,location.y,scl,scl);
  }
}
