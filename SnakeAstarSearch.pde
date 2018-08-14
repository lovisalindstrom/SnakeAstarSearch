//From Coding Challenge #3: The Snake Game by Daniel Shiffman
//https://www.youtube.com/watch?v=AaGK-fj-BAM

Astar graph;
Snake snake;
Food food;
float scl = 20; //scale
int COLS = 30;
int ROWS = 30;

boolean goingRight = true;
boolean goingLeft = false;
boolean goingUp = false;
boolean goingDown = false;

void setup(){
  size(600, 600);
  frameRate(10);
  graph = new Astar();
  graph.setupSearch();
  snake = new Snake(0,0,1,0);
  food = pickFoodLocation();
  graph.search(snake, food);
  //snake.takePath(graph.path);
}

public Food pickFoodLocation(){
  int cols = floor(width/scl);
  int rows = floor(height/scl);
  PVector foodVector = new PVector(floor(random(cols)), floor(random(rows)));
  food = new Food(foodVector);
  foodVector.mult(scl);
  return food;
}

void draw(){
  //background(70);
  
  if(snake.eat(food)){
    food = pickFoodLocation();
    graph.search(snake, food);
    
  }
  
  //snake.takePath(graph.path);
  snake.death();
  snake.boundaries();
  snake.update();

  snake.show();
  food.show();
  
}

void keyPressed(){
    if(keyCode == UP && !goingDown){
      snake.dir(0, -1);
      goingUp = true;
      goingDown = false;
      goingLeft = false;
      goingRight = false;
    }else if(keyCode == DOWN && !goingUp){
      snake.dir(0, 1);
      goingUp = false;
      goingDown = true;
      goingLeft = false;
      goingRight = false;
    }else if(keyCode == LEFT && !goingRight){
      snake.dir(-1,0);
      goingUp = false;
      goingDown = false;
      goingLeft = true;
      goingRight = false;
    }else if(keyCode == RIGHT && !goingLeft){
      snake.dir(1, 0);
      goingUp = false;
      goingDown = false;
      goingLeft = false;
      goingRight = true;
    }
}
