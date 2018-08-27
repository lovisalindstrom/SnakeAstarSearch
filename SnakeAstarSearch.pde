//Inspiration taken from from Coding Challenge #3: The Snake Game by Daniel Shiffman
//https://www.youtube.com/watch?v=AaGK-fj-BAM

//Grupp 11
//Lovisa Lindström 
//Ellinor Granlund

Astar graph;
Snake snake;
Food previousFood;
Food food;
int scl = 20; //scale
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
  
  snake = new Snake(0, 0, 1, 0);
  System.out.println("Snake col: " + snake.col +  " " + snake.row);
  food = pickFoodLocation();
  graph.search(0, 0, food.col, food.row);
}

public Food pickFoodLocation(){
  int col = floor(random(COLS));
  int row = floor(random(ROWS));
  System.out.println("Food col: " + col + ", row: " + row);
  PVector foodVector = new PVector(col, row);
  foodVector.mult(scl);
  food = new Food(foodVector, col, row);
  System.out.println("Food location: x" + food.location.x + " y" + food.location.y);
  return food;
}

void draw(){
  background(71);
  
  graph.drawGrid();
  graph.drawOpenSet();
  graph.drawClosedSet();
  
  if(snake.eat(food)){
    food = pickFoodLocation();
    graph.search(snake.col, snake.row, food.col, food.row);
  }
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
