/*Lutfiadi Rahmanto, Arduino Verkstad Hackathon 2013*/

class Grid {
  
  //ID, Coordinate, and Position
  int id; 
  
  //2D Array Index
  int xIdx;
  int yIdx;
  
  //2D Position (Relative to the Plane)
  float xPos;
  float yPos;
  
  //Pre-determined Status
  int adjNum;
  boolean mine;
  
  //In-game Status
  boolean isOpened=false;
  boolean isQueued=false;
  boolean isFlag=false;
  
  //Output (Display)
  color c;
  
  //Constructor
  Grid(int tempId) { 
    id = tempId;
    xIdx = id%cols;
    yIdx = id/rows;
    
    xPos = xIdx*distance + 40;
    yPos = yIdx*distance + 40;
    
    c = color(0,0,0);
  }

  //Coordinate to Idx
  int coorToIdx(int x, int y){
    int temp = (cols * y) + x; 
    return temp;
  }

  
  void setTheMine(){
    mine=true;
  }
  
  void countAdjacentMines(){
    int mineCount=0;
    
    //Over
    if(yIdx!=0){
      //Over Left
      if(xIdx!=0){
        if(grids[coorToIdx(xIdx-1,yIdx-1)].mine==true)
          mineCount++;
      }
      
      //Over Center
      if(grids[coorToIdx(xIdx,yIdx-1)].mine==true)
          mineCount++;
      
      //Over Right
      if(xIdx!=cols-1){
         if(grids[coorToIdx(xIdx+1,yIdx-1)].mine==true)
           mineCount++;
      }
    }
    
    //Mid
    //Mid Left
    if(xIdx!=0){
      if(grids[coorToIdx(xIdx-1,yIdx)].mine==true)
          mineCount++;
      }
      
    //Mid Center
     if(grids[coorToIdx(xIdx,yIdx)].mine==true)
           mineCount++;
      
    //Mid Right
      if(xIdx!=cols-1){
        if(grids[coorToIdx(xIdx+1,yIdx)].mine==true)
           mineCount++;
      }
    
    //Below
    if(yIdx!=rows-1){
      //Below Left
      if(xIdx!=0){
        if(grids[coorToIdx(xIdx-1,yIdx+1)].mine==true)
          mineCount++;
      }
      
      //Below Center
         if(grids[coorToIdx(xIdx,yIdx+1)].mine==true)
           mineCount++;
      
      //Below Right
      if(xIdx!=cols-1){
         if(grids[coorToIdx(xIdx+1,yIdx+1)].mine==true)
           mineCount++;
      }
    }
    
    adjNum=mineCount;
  }

  void isInQueue(){
    isQueued = gridsQueue.searchQueue(id);
  }

  void openSingleGrid(){
    isInQueue();
    
    if(isOpened!=true && isQueued!=true && mine!=true){
       isOpened=true;
       c=color(0,0,200);
       
       if(adjNum==0 && mine!=true)
       {
         c=color(0,0,254);
         queueAdjacentGrids();
       }
    }

    if(mine==true){
         revealMines();
       }
  }
  
  void queueSingleGrid(int tXidx, int tYidx){
    int tIdx = coorToIdx(tXidx, tYidx);
    grids[tIdx].isQueued = gridsQueue.searchQueue(tIdx);
    
    if(grids[tIdx].isOpened!=true && grids[tIdx].isQueued!=true){
       gridsQueue.pushQueue(tIdx);
    }
  }

  void queueAdjacentGrids(){
    
    //Over
    if(yIdx!=0){
      //Over Left
      if(xIdx!=0){
        queueSingleGrid(xIdx-1,yIdx-1);
      }
      
      //Over Center
      queueSingleGrid(xIdx,yIdx-1);
      
      //Over Right
      if(xIdx!=cols-1){
        queueSingleGrid(xIdx+1,yIdx-1);
      }
    }
    
    //Mid
    //Mid Left
    if(xIdx!=0){
        queueSingleGrid(xIdx-1,yIdx);
      }
      
    //Mid Center
        queueSingleGrid(xIdx,yIdx);
      
    //Mid Right
      if(xIdx!=cols-1){
        queueSingleGrid(xIdx+1,yIdx);
      }
    
    //Below
    if(yIdx!=rows-1){
      //Below Left
      if(xIdx!=0){
        queueSingleGrid(xIdx-1,yIdx+1);
      }
      
      //Below Center
          queueSingleGrid(xIdx,yIdx+1);
      
      //Below Right
      if(xIdx!=cols-1){
          queueSingleGrid(xIdx+1,yIdx+1);
      }
    }
  }

  void putFlagToGrid(){
    if(!isOpened)
    {
      if(isFlag)
      {
        isFlag=false;
        c=color(0,0,0);
      }
      else{
        isFlag=true;
        c=color(200,0,200);
      }
    }
  }

  //Interaction
  void detectClick(){
    if(mouseX>xPos-radius && mouseX<xPos+radius && mouseY>yPos-radius && mouseY<yPos+radius)
     {
        openSingleGrid();
        iterateGrids();
      }
     else
     {
        
     }  
  }

  void detectFlagClick(){
     if(mouseX>xPos-radius && mouseX<xPos+radius && mouseY>yPos-radius && mouseY<yPos+radius)
     {
        putFlagToGrid();
     }
     else
     {
        
     } 
  }

  //Display
  void display() {
    //Displaying Circles
    stroke(0);
    fill(c);
    rectMode(CENTER);
    ellipse(xPos,yPos,radius,radius);
    
    //Displaying Numbers
    if(isOpened)
     {
      textSize(10);
      fill(255,255,255);
      if(!mine){
        text(adjNum,xPos-2,yPos+4);
      }
    }
  }
  
  void iterateGrids(){
  while(gridsQueue.size!=0)
  {
    int tempIdx = gridsQueue.popQueue();
    grids[tempIdx].openSingleGrid();
  }
}
  
}
