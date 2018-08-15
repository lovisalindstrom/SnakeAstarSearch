
class Snake {
  int x;
  int y;
  int xspeed;
  int yspeed;
  int total;
  int col;
  int row;

  Snake[] tail  = new Snake[100];
  
  public Snake(int x, int y, int xspeed, int yspeed){
    this.x = x;
    this.y = y;
    this.xspeed = xspeed;
    this.yspeed = yspeed;
    this.total = 0;
    this.col = x / 20;
    this.row = y / 20;
  }
  
  void update(){
    for(int i = 0; i < tail.length-1; i++){
      tail[i] = tail[i+1];
    }

    if(total >= 1){
      tail[total-1] = new Snake(x, y, xspeed, yspeed);
    }
    
    x = x + xspeed * scl;
    y = y + yspeed * scl;
    //col = x / scl;
    //row = y / scl;
    //System.out.println("Snake col: " + col + " row: " + row);
      
    //x = constrain(x, 0, width-scl); 
    //y = constrain(y, 0, height-scl);
  }
  
  
  void boundaries(){
    if(x > width){
      x = 0;
    }else if(x < 0){
      x = width;
    }else if(y > height){
      y = 0;
    }else if(y < 0){
      y = height;
    }
  }
  
  boolean eat(Food food){
    float d = dist(x, y, food.location.x, food.location.y);
    if(d < 1){
      total++;
      return true;
    }else{
      return false;
    }
  }
  

  void death(){
    for(int i = 0; i < tail.length; i++){
      Snake s = tail[i];
      if(s != null){
        float d = dist(x, y, s.x, s.y);
        if(d < 1){
          total = 0;
          tail = new Snake[100];
        }
      }
    }
  }
  
  
 // void takePath(ArrayList<Spot> path){
 //  for(int i = 0; i < path.size(); i++){
 //    snake.xspeed = (int)path.get(i).x;
 //    snake.yspeed = (int)path.get(i).y;
 //  }
 //}
 
  void show(){
    fill(255);
    for(int i = 0; i < tail.length; i++){
      if(tail[i] != null){
        rect(tail[i].x, tail[i].y, scl, scl);
      }
    }
    rect(x, y,scl,scl);
  }
  
  void dir(int x, int y){
    xspeed = x;
    yspeed = y;
  }
  
}
