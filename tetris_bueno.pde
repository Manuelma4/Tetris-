/Arreglo para las figuras
int[][] Cuadrado = {{0,0}, {1,0}, {0,1}, {1,1}};
int[][] Linea = {{0,0}, {1,0}, {2,0}, {3,0}};
int[][] Triangulo = {{0,0}, {1,0}, {2,0}, {1,1}};
int[][] Tetrominillo_Derecha = {{0,0}, {1,0}, {2,0}, {2,1}};
int[][] Tetrominillo_Izquierda = {{0,0}, {1,0}, {2,0}, {0,1}};
int[][] Figura_Culebrillaxd = {{0,0}, {1,0}, {1,1}, {2,1}};
int[][] Figura_Culebrilla2xd = {{0,1}, {1,0}, {1,1}, {2,0}};
boolean Activo, Pasa_Izquierda, Pasa_derecha; 
int Escoger, contadorRotaciones;
int Nivel;
int Estado_Juego;
int[][][] colores;
int r,g,b;
int w;
int ejeX, ejeY;
int puntaje;
void setup(){
  size(600 , 600);
  textSize(44);
  Estado_Juego = 1;
}
Figura figura, Figura_presente;
Fondito Fd;
void dibujarGrilla(){
  strokeWeight(2);
    stroke(155);
    int w;
    w = width / 24;
    for(int i = 0; i < 13; i++){
      line(0,w*i, width/2, w*i);
      line(0,w*(i+12), width/2, w*(i+12));
      line(w*i, 0, w*i, height);
    }
}
void draw(){
  dibujarGrilla();
   if(Estado_Juego == 1){
     Fd.pantalla();
     drawFigura();
     Puntaje_Nivel();
     if(!Fd.Inicio()){
       Estado_Juego = 2;
       
     }
   }
   if(Estado_Juego == 2){
     fill(0);
     text("  Presiona clic  ", 30, height/3);
     text("para jugar de nuevo", 30, height/2);
     fill(255);
     text("  Presiona clic ", 32, height/3+2);
     text("para jugar de nuevo", 32, height/2+2);
     if(mousePressed){
       setup();
     }
   }
     
}
class Fondito{

     int[][][] colores;
     int r,g,b;
     int w;
     int ejeX, ejeY;
     int puntaje;
     
  Fondito(){
      colores = new int[12][24][3];
      w = width / 24;
  }
  
  //describe el metodo para dibujar un cuadrado para cada "x" y "y" usando el sistemas de colores RGB
  void pantalla(){
      for(int i = 0; i < 12; i++){
        for(int j = 0; j < 24; j++){
          r = colores[i][j][0];
          g = colores[i][j][1];
          b = colores[i][j][2];
          fill(r,g,b);
          rect(i*w, j*w, w, w);
        }
      }
      for(int i = 0; i < 24; i++){
        if(Ok_Linea(i)){
          Quitar_Fila(i);
        }
      }
  }
  
  void RealizarFigura(Figura s){
       //Obtiene theX y theY de cada bloque
       for(int i = 0; i < 4; i++){
         ejeX = s.LaFigura[i][0];
         ejeY = s.LaFigura[i][1];
         //Imprime lcontadorRotaciones colores de la figura dentro de valores de x,y
         colores[ejeX][ejeY][0] = s.r;
         colores[ejeX][ejeY][1] = s.g;
         colores[ejeX][ejeY][2] = s.b;
       }       
   }
   boolean Ok_Linea(int fila){
     for(int i = 0; i < 12; i++){
       if(colores[i][fila][0] == 0 && colores[i][fila][1] == 0 && colores[i][fila][2] == 0){
         return false;
       }
     }  
     return true;
   }
   void Quitar_Fila(int fila){
     puntaje++;
     int[][][] nuevoFondito = new int[12][24][3];
     for(int i = 0; i < 12; i++){
       for(int j = 23; j > fila; j--){
         for(int a = 0; a < 3; a++){
           nuevoFondito[i][j][a] = colores[i][j][a];
         }
       }    
     }
     for(int r = fila; r >= 1; r--){
       for(int j = 0; j < 12; j++){
         nuevoFondito[j][r][0] = colores[j][r-1][0];
         nuevoFondito[j][r][1] = colores[j][r-1][1];
         nuevoFondito[j][r][2] = colores[j][r-1][2];
       }
     }     
     colores = nuevoFondito;
   }
   
   boolean Inicio(){
     if(colores[0][0][0] != 0){
       return false;
     } else {
       return true;
     }
   }   
   
}  

class Figura{
   
  //7 Tetris Forma
  int[][] Cuadrado = {{0,0}, {1,0}, {0,1}, {1,1}};
  int[][] Linea = {{0,0}, {1,0}, {2,0}, {3,0}};
  int[][] Triangulo = {{0,0}, {1,0}, {2,0}, {1,1}};
  int[][] Tetrominillo_Derecha = {{0,0}, {1,0}, {2,0}, {2,1}};
  int[][] Tetrominillo_Izquierda = {{0,0}, {1,0}, {2,0}, {0,1}};
  int[][] Figura_Culebrillaxd = {{0,0}, {1,0}, {1,1}, {2,1}};
  int[][] Figura_Culebrilla2xd = {{0,1}, {1,0}, {1,1}, {2,0}};
  int[][] LaFigura, OtraFigura;   //Figura original
  boolean Activo, Pasa_Izquierda, Pasa_derecha;
  int contador, r, g, b;
  float w; 
  int Escoger, contadorRotaciones;
  int ejeX, ejeY;
  int Nivel;
  
  public Figura(){
    Nivel = 31;
    Escoger = (int)random(7);
    w = width/24;
    switch(Escoger){
       case 0: LaFigura = Cuadrado;
               g = 188;
               break;
       case 1: LaFigura = Linea;
               b = 200;
               break;      
       case 2: LaFigura = Triangulo;
               r = 255;
               break;
       case 3: LaFigura = Tetrominillo_Izquierda;
               b = 170;
               g = 135;
               break;               
       case 4: LaFigura = Tetrominillo_Derecha;
               g = 255;
               r = 255;
               break;
       case 5: LaFigura = Figura_Culebrillaxd;
               r = 200;
               b = 155;
               break;
       case 6: LaFigura = Figura_Culebrilla2xd;
               b = 180;
               g = 255;
               b = 60;
               break;               
    }
    contador = 1;
    OtraFigura = LaFigura;
    contadorRotaciones = 0;
  }
  
  void pantalla(){
    fill(r,g,b);
    for(int i = 0; i < 4; i++){
        rect(LaFigura[i][0]*w, LaFigura[i][1]*w, w, w);  
    }
  }
  
  void Mostrar_Figura_presente(){
    fill(0,0,0);
    rect(width/2, 0, width/2, height);
    fill(0);
    text("SIGUIENTE", width/2 + 10, 50);
    text("FIGURA:", width/2 + 10, 100);
    fill(255);
    text("SIGUIENTE ", width/2 + 15, 55);
    text("FIGURA:", width/2 + 15, 105);
    fill(r,g,b);
    for(int i = 0; i < 4; i++){
        rect(LaFigura[i][0]*w + width/4 *3 - 2*w, LaFigura[i][1]*w + 150, w, w);  
    }
  }
  
  void Abajo(){
     Comprobacion();
     if(contador % Nivel == 0){
       C_Mueve("DOWN");
     }
     contador++;
  }

  boolean ComprobarSitio(String sitio){     
      switch(sitio){ 
         case "LEFT":
           for(int i = 0; i < 4; i++){
              if(LaFigura[i][0]<1){
                return false;
              }
           }
           break;
         case "RIGHT":
           for(int i = 0; i < 4; i++){
              if(LaFigura[i][0]>10){
                return false;
              }
           }
           break;
         case "DOWN":
           for(int i = 0; i < 4; i++){
              if(LaFigura[i][1]>22){
                Activo = false;
                return false;
              }
           }
           break;           
      }
      return true;
  }

  void C_Mueve(String direccion){
    if(ComprobarSitio(direccion)){
       switch(direccion){
         case "LEFT":
           for(int i = 0; i < 4; i++){
              LaFigura[i][0]--;  
           } 
           break;
         case "RIGHT":
           for(int i = 0; i < 4; i++){
              LaFigura[i][0]++;  
           }
           break;
         case "DOWN":
           for(int i = 0; i < 4; i++){
              LaFigura[i][1]++;  
           }     
           break;
       }     
    }
  }
   
  void rotate(){
    if(LaFigura != Cuadrado){
       int[][] Rotar = new int[4][2];
       if(contadorRotaciones % 4 == 0){
         for(int i = 0; i < 4; i++){
            Rotar[i][0] = OtraFigura[i][1] - LaFigura[1][0];
            Rotar[i][1] = -OtraFigura[i][0] - LaFigura[1][1];
         }
       } else if (contadorRotaciones % 4 == 1){
          for(int i = 0; i < 4; i++){
            Rotar[i][0] = -OtraFigura[i][0] - LaFigura[1][0];
            Rotar[i][1] = -OtraFigura[i][1] - LaFigura[1][1];
         }
       } else if (contadorRotaciones % 4 == 2){ 
         for(int i = 0; i < 4; i++){
            Rotar[i][0] = -OtraFigura[i][1] - LaFigura[1][0];
            Rotar[i][1] = OtraFigura[i][0] - LaFigura[1][1];
         }
       } else if (contadorRotaciones % 4 == 3){
          for(int i = 0; i < 4; i++){
            Rotar[i][0] = OtraFigura[i][0] - LaFigura[1][0];
            Rotar[i][1] = OtraFigura[i][1] - LaFigura[1][1];
         } 
       }
       LaFigura = Rotar;
    }
  }


  boolean Limites(Fondito b){
      for(int i = 0; i < 4; i++) {
         ejeX = LaFigura[i][0];
         ejeY = LaFigura[i][1];
         if(ejeX >= 0 && ejeX < 12 && ejeY >= 0 && ejeY < 23){
           for(int a = 0; a < 3; a++){
             if(b.colores[ejeX][ejeY+1][a] != 0){
                return false;   
             }
           }
         }
      } 
      return true;
  }

  void ComprobarBordes(){
    if(Pasa_Izquierda){
      for(int i = 0; i < 4; i++){
          LaFigura[i][0]++;
      }
      Pasa_Izquierda = false;
    }
    if(Pasa_derecha){
      for(int i = 0; i < 4; i++){
          LaFigura[i][0]--;
      }
      Pasa_derecha = false;
    }    
  }
 
  void Comprobacion(){
    for(int i = 0; i < 4; i++){
      if(LaFigura[i][0] < 0){
        Pasa_Izquierda = true;
        ComprobarBordes();
      } else if(LaFigura[i][0] > 11){
        Pasa_derecha = true;
        ComprobarBordes();
      }
    }
  }
}




void Puntaje_Nivel(){
   fill(0);
   text("Puntuación: " + Fd.puntaje, width/2 + 2, height - 15);
   fill(255);
   text("Puntuación: " + Fd.puntaje, width/2 + 7, height - 15); 
   if(Fd.puntaje < 30){
     figura.Nivel = 31 - Fd.puntaje;
   if(Fd.puntaje >= 10){
     textSize(44);
     fill(264,0,0);
     text("Sigue asi UwU", width/2 + 2, 320);}
   else{
     textSize(30);
     fill(264,0,0);
     text("Tu puedes UwU", width/2+2, 320);
   if(Fd.puntaje >=30){
     fill(0,264,0);
     text("JP severo teacher", width/2 + 2, 320);
   }
   }
   }
}
void drawFigura(){
   figura.pantalla();
   Figura_presente.Mostrar_Figura_presente();
   if(figura.Limites(Fd)){
     figura.Abajo();
   } else {
     figura.Activo = false;
   }
   if(!figura.Activo){
    Fd.RealizarFigura(figura);
    figura = Figura_presente;
    figura.Activo = true;
    Figura_presente = new Figura();
  } 

}
void keyPressed(){
  if(keyCode == RIGHT){
    figura.C_Mueve("RIGHT");
  } else if (keyCode == LEFT){
    figura.C_Mueve("LEFT");
  } else if (keyCode == DOWN){
    figura.C_Mueve("DOWN");
  }
}

void keyReleased(){
  if(keyCode == UP){
    figura.rotate();
    figura.rotate();
  } 
  figura.contadorRotaciones++;
}
