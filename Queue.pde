/*Lutfiadi Rahmanto, Arduino Verkstad Hackathon 2013*/

class Queue{
  int[] queueArray = new int[64];
  int size;
  
  //Constructor
  Queue()
  {
    size=0;
  }
  
  //Push
  void pushQueue(int num){
    queueArray[size]=num;
    size++;
  }
  
  //Pop
  int popQueue(){
    int temp = queueArray[0];
    
    if(size!=0)
    {
      for(int i=0; i<size-1; i++){
        queueArray[i]=queueArray[i+1];
      }
      size--;
    }
    
    return temp;
  }
  
  boolean searchQueue(int id){
    boolean temp=false;
    
    if(size!=0)
    {
      for(int i=0; i<size; i++)
      {
        if(queueArray[i]==id)
          temp=true;
      }
    }
    return temp;
  }
  
}
