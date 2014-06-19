/*Lutfiadi Rahmanto, Arduino Verkstad Hackathon 2013*/

//Size of Area
int cols = 7;
int rows = 7;

//Related to Display
int radius = 20;
int distance = 40;

//Number of Mines on The Game
int numOfMines = 8;

//2D Array represented in 1D Array
Grid[] grids;

//Queue for Grid Opening Iteration
Queue gridsQueue;

void setup() {
  size(800,800);
 
  //Initialize Grids
  grids = new Grid[cols * rows];
  for(int i=0; i<cols * rows; i++){
    grids[i] = new Grid(i);
  }
 
  //Setup Game
  setMines(); //Put mines on random location
  setNumberOfMines(); //Put number of adjacent mines to every grids
   
  //Initialize Queue
  gridsQueue = new Queue();
}

void draw() {
  background(255);
  
  for(int i=0; i<cols * rows; i++){
    grids[i].display();
  }
  
}

void mouseClicked(){
  
  for(int i=0; i<cols * rows; i++){
    if(keyPressed && key == 'f')
    {
      grids[i].detectFlagClick();
    }
    else
    {
      grids[i].detectClick();
    }
  }
}

//Put mines on random location
void setMines(){
  int mc;
  
  for(int i=0; i<numOfMines; i++)
    {
      mc = (int)random(cols * rows);
      
      while(grids[mc].mine==true)
      {
        mc = (int)random(cols * rows);
      }
      grids[mc].setTheMine();
      
    }
}

//Put number of adjacent mines to every grids
void setNumberOfMines(){
  for(int i=0; i<cols * rows; i++)
  {
    grids[i].countAdjacentMines();
  }
}



void revealMines(){
  for(int i=0; i<cols*rows; i++){
    if(grids[i].mine==true)
      grids[i].c = color(255,0,0);
  }
}


