import processing.serial.*;
import cc.arduino.*;
/*Bubble b1;
 Bubble b2;*/

//------------- Variables de la probeta -----------// 
int posY = 50, //posición y de la probeta
    posX = 210, //posición x de la probeta
    L = 500,  //longitud de la probeta
    d = 80;  //diámetro de la probeta

//------------- Variables de la base -----------// 
int B = 100, //altura de la base
    a = 40, //variable para que d+2a= ancho inferior de la base
    
    //Esquinas:
    Ex1= posX,
    Ey1= L+posY,
    Ex2= posX+d,
    Ey2= L+posY,
    Ex3= posX+d+a,
    Ey3= L+B+posY,
    Ex4= posX-a,
    Ey4= L+B+posY;

//------------- Variables de la bolita-----------// 
int db = d-5, //diámetro de la bolita
    posXbol= posX+d/2; // posición x de la bolita para que quede centrada en la probeta


int x1 = L/2+posY;  //510 abajo, 300: centro  //Se obtiene de arduino
int va = -5;

//---valores para animar sin entrada de arduino---/
int tope_s = posY+db/2+10,  //+10 para que no se salga de la probeta
    tope_i = L-db/2-10;

void setup() {
  //ventana
  size(500, 700);
  
  pushStyle(); //new style
  fill(0, 255, 0);
  quad(Ex1, Ey1, Ex2,Ey2, Ex3,Ey3 ,Ex4 ,Ey4 );
  popStyle(); //original style
}

void draw() {
  pushStyle(); //new style
  fill(255, 255, 255);
  rect(posX, posY, d, L);
  popStyle(); //original style
  //background(255);
  circle(posXbol, x1, db);
 
  x1 = x1 + va;
   //---Simulacion sin arduino---//
  if(x1<tope_s){
    va=5;
    
  }
  if(x1>tope_i){
    va=-5;
    
  }
 //---Fin simulacion sin arduino---//
  
}
