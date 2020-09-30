public class Grid{

  private int w;
  
  public Grid(){
      w = width / 24;
  }
    
  public void display(){
    strokeWeight(2);
    stroke(155);
    for(int i = 0; i < 13; i++){
        line(0,w*i, width/2, w*i);
        line(0,w*(i+12), width/2, w*(i+12));
        line(w*i, 0, w*i, height);
    }
  }
  
}

public class Background{

     private int[][][] colors;
     private int r,g,b;
     private int w;
     private int theX, theY;
     private int score;
     
  public Background(){
      colors = new int[12][24][3];
      w = width / 24;
  }
  
  //describe el metodo para dibujar un rectangulo para cada "x" y "y" usando el sistemas de colores RGB the colors RGB
  public void pantalla(){
      for(int i = 0; i < 12; i++){
        for(int j = 0; j < 24; j++){
          r = colors[i][j][0];
          g = colors[i][j][1];
          b = colors[i][j][2];
          fill(r,g,b);
          rect(i*w, j*w, w, w);
        }
      }
      for(int i = 0; i < 24; i++){
        if(checkLine(i)){
          removeLine(i);
        }
      }
  }
  
  void writeShape(Shape s){
       //get theX and theY of each block
       for(int i = 0; i < 4; i++){
         theX = s.theShape[i][0];
         theY = s.theShape[i][1];
         //Write the colors of the shape into these x,y valuees
         colors[theX][theY][0] = s.r;
         colors[theX][theY][1] = s.g;
         colors[theX][theY][2] = s.b;
       }       
   }
   
   //Check for a complete line (boolean)
   public boolean checkLine(int row){
     for(int i = 0; i < 12; i++){
       if(colors[i][row][0] == 0 && colors[i][row][1] == 0 && colors[i][row][2] == 0){
         return false;
       }
     }  
     return true;
   }

   //Remove Lines (if full)
   void removeLine(int row){
     score++;
     int[][][] newBackground = new int[12][24][3];
     for(int i = 0; i < 12; i++){
       for(int j = 23; j > row; j--){
         for(int a = 0; a < 3; a++){
           newBackground[i][j][a] = colors[i][j][a];
         }
       }    
     }
     for(int r = row; r >= 1; r--){
       for(int j = 0; j < 12; j++){
         newBackground[j][r][0] = colors[j][r-1][0];
         newBackground[j][r][1] = colors[j][r-1][1];
         newBackground[j][r][2] = colors[j][r-1][2];
       }
     }     
     colors = newBackground;
   }
   
   boolean gameOn(){
     if(colors[0][0][0] != 0){
       return false;
     } else {
       return true;
     }
   }   
   
}  

public class Shape{
   
  //7 Tetris Shapes
  private int[][] square = {{0,0}, {1,0}, {0,1}, {1,1}};
  private int[][] ln = {{0,0}, {1,0}, {2,0}, {3,0}};
  private int[][] tri = {{0,0}, {1,0}, {2,0}, {1,1}};
  private int[][] rightL = {{0,0}, {1,0}, {2,0}, {2,1}};
  private int[][] leftL = {{0,0}, {1,0}, {2,0}, {0,1}};
  private int[][] theS = {{0,0}, {1,0}, {1,1}, {2,1}};
  private int[][] otherS = {{0,1}, {1,0}, {1,1}, {2,0}};
  
  //other fields
  private int[][] theShape, oS;   //Original Shape
  private boolean isActive, isTooLeft, isTooRight;
  private int counter, r, g, b;
  private float w; //width of each block in the piece
  private int choice, rotCount;
  private int theX, theY;
  private int level;
  
  public Shape(){
    level = 31;
    choice = (int)random(7);
    w = width/24;
    switch(choice){
       case 0: theShape = square;
               r = 255;
               break;
       case 1: theShape = ln;
               g = 255;
               break;      
       case 2: theShape = tri;
               b = 255;
               break;
       case 3: theShape = leftL;
               r = 255;
               g = 255;
               break;               
       case 4: theShape = rightL;
               g = 255;
               b = 255;
               break;
       case 5: theShape = theS;
               r = 255;
               b = 255;
               break;
       case 6: theShape = otherS;
               r = 255;
               g = 255;
               b = 255;
               break;               
    }
    counter = 1;
    oS = theShape;
    rotCount = 0;
  }
  
  void pantalla(){
    fill(r,g,b);
    for(int i = 0; i < 4; i++){
        rect(theShape[i][0]*w, theShape[i][1]*w, w, w);  
    }
  }
  
  void showOnDeck(){
    fill(0,0,100);
    rect(width/2, 0, width/2, height);
    fill(0);
    text("SIGUIENTE FIGURA:", width/2 + 10, 50);
    fill(255);
    text("SIGUIENTE FIGURA:", width/2 + 15, 55);
    fill(r,g,b);
    for(int i = 0; i < 4; i++){
        rect(theShape[i][0]*w + width/4 *3 - 2*w, theShape[i][1]*w + 100, w, w);  
    }
  }
  
  void moveDown(){
     checkEdges();
     if(counter % level == 0){
       move("DOWN");
     }
     counter++;
  }

  boolean checkSide(String side){     
      switch(side){ 
         case "LEFT":
           for(int i = 0; i < 4; i++){
              if(theShape[i][0]<1){
                return false;
              }
           }
           break;
         case "RIGHT":
           for(int i = 0; i < 4; i++){
              if(theShape[i][0]>10){
                return false;
              }
           }
           break;
         case "DOWN":
           for(int i = 0; i < 4; i++){
              if(theShape[i][1]>22){
                isActive = false;
                return false;
              }
           }
           break;           
      }
      return true;
  }

  void move(String dir){
    if(checkSide(dir)){
       switch(dir){
         case "LEFT":
           for(int i = 0; i < 4; i++){
              theShape[i][0]--;  
           } 
           break;
         case "RIGHT":
           for(int i = 0; i < 4; i++){
              theShape[i][0]++;  
           }
           break;
         case "DOWN":
           for(int i = 0; i < 4; i++){
              theShape[i][1]++;  
           }     
           break;
       }     
    }
  }
   
  void rotate(){
    if(theShape != square){
       int[][] rotated = new int[4][2];
       if(rotCount % 4 == 0){
         for(int i = 0; i < 4; i++){
            rotated[i][0] = oS[i][1] - theShape[1][0];
            rotated[i][1] = -oS[i][0] - theShape[1][1];
         }
       } else if (rotCount % 4 == 1){
          for(int i = 0; i < 4; i++){
            rotated[i][0] = -oS[i][0] - theShape[1][0];
            rotated[i][1] = -oS[i][1] - theShape[1][1];
         }
       } else if (rotCount % 4 == 2){ 
         for(int i = 0; i < 4; i++){
            rotated[i][0] = -oS[i][1] - theShape[1][0];
            rotated[i][1] = oS[i][0] - theShape[1][1];
         }
       } else if (rotCount % 4 == 3){
          for(int i = 0; i < 4; i++){
            rotated[i][0] = oS[i][0] - theShape[1][0];
            rotated[i][1] = oS[i][1] - theShape[1][1];
         } 
       }
       theShape = rotated;
    }
  }


  boolean checkBack(Background b){
      for(int i = 0; i < 4; i++) {
         theX = theShape[i][0];
         theY = theShape[i][1];
         if(theX >= 0 && theX < 12 && theY >= 0 && theY < 23){
           for(int a = 0; a < 3; a++){
             if(b.colors[theX][theY+1][a] != 0){
                return false;   
             }
           }
         }//Check for OUT OF BOUNDS
      } // Check each block
      return true;
  }

  
  //THE FOLLOWING CODE WAS NOT ON THE TUTORIAL BUT ADDED AFTER I PUBLISHED 
  void debugEdge(){
    if(isTooLeft){
      for(int i = 0; i < 4; i++){
          theShape[i][0]++;
      }
      isTooLeft = false;
    }
    if(isTooRight){
      for(int i = 0; i < 4; i++){
          theShape[i][0]--;
      }
      isTooRight = false;
    }    
  }
  
  //This METHOD was called in the moveDown() function
  void checkEdges(){
    for(int i = 0; i < 4; i++){
      if(theShape[i][0] < 0){
        isTooLeft = true;
        debugEdge();
      } else if(theShape[i][0] > 11){
        isTooRight = true;
        debugEdge();
      }
    }
  }
}
Grid grid;
Shape shape, onDeck;
Background bg;
int gameState;

void setup(){
  size(600 , 600);  
  grid = new Grid();
  shape = new Shape();
  shape.isActive = true;
  onDeck = new Shape();
  bg = new Background();
  textSize(44);
  gameState = 1;
}

void draw(){
   if(gameState == 1){
     bg.pantalla();
     grid.display();
     drawShapes();
     scoreAndLevel();
     if(!bg.gameOn()){
       gameState = 2;
     }
   }
   if(gameState == 2){
     fill(0);
     text("Click Anywhere to Play Again", 30, height/2);
     fill(255);
     text("Click Anywhere to Play Again", 32, height/2+2);
     if(mousePressed){
       setup();
     }
   }
     
}

void scoreAndLevel(){
   fill(0);
   text("Score: " + bg.score, width/2 + 100, height - 100);
   fill(255);
   text("Score: " + bg.score, width/2 + 105, height - 95); 
   if(bg.score < 30){
     shape.level = 31 - bg.score;
   }
}
void drawShapes(){
   shape.pantalla();
   onDeck.showOnDeck();
   if(shape.checkBack(bg)){
     shape.moveDown();
   } else {
     shape.isActive = false;
   }
   if(!shape.isActive){
    bg.writeShape(shape);
    shape = onDeck;
    shape.isActive = true;
    onDeck = new Shape();
  } 

}
void keyPressed(){
  if(keyCode == RIGHT){
    shape.move("RIGHT");
  } else if (keyCode == LEFT){
    shape.move("LEFT");
  } else if (keyCode == DOWN){
    shape.move("DOWN");
  }
}

void keyReleased(){
  if(keyCode == UP){
    shape.rotate();
    shape.rotate();
  } 
  shape.rotCount++;
}
