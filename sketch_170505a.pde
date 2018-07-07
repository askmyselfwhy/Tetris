Board b;
void setup(){
  size(640,640);
  b = new Board(15);
  b.createFigure();
}

void draw(){
  background(128);
  b.show();
}

void keyPressed(){
  if(keyCode == 38){
    b.turnFigure();
  }
  else if(keyCode == 37){
    b.moveFigureLeft();
  }
  else if(keyCode == 39){
    b.moveFigureRight();
  }
  else if(keyCode == 40){
    b.increaseSpeed();
  }
}