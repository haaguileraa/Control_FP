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
    posXbol= posX+d/2, // posición x de la bolita para que quede centrada en la probeta
    r= db/2; //radio de la esfera

int x1 = L/2+posY;  //510 abajo, 300: centro  //Se obtiene de arduino
int va = -5;
float rx  = 0;
float ry  = 0;
//---valores para animar sin entrada de arduino---/
int tope_s = posY+db/2+10,  //+10 para que no se salga de la probeta
    tope_i = L-db/2-10;
//---valores para animar con entrada de arduino---/
Serial senalArd;



void setup() {
  //ventana
  size(500, 700, P3D);
 // println(PI);
  
  ///*
  //Arduino: 
  String puerto ="/dev/ttyUSB0";  //Cambiar por el puerto en el que esté el arduino
  print(puerto);
  senalArd= new Serial(this, puerto, 2000000); //tercer argumento = baudios.*/
}

void draw() {
  //-----Delay

  while (senalArd.available() > 0) {
    int inByte = senalArd.read();
    println(inByte);
  //}
  //delay(100);  // mejor al final??


    //--------PROBETA-----------//
    pushStyle(); //new style
    fill(255, 255, 255);
    rect(posX, posY, d, L);
    popStyle(); //original style

    //--------BASE-----------//
    pushStyle(); //new style
    fill(0, 255, 0);
    translate(0, 0);
    quad(Ex1, Ey1, Ex2,Ey2, Ex3,Ey3 ,Ex4 ,Ey4 );
    popStyle(); //original style
    
    //--------BOLITA-----------//
    pushStyle();
    noStroke();
    fill(0, 51, 102);
    lightSpecular(255, 255, 255);
    directionalLight(0, 10, 0, 0, 0, -10);
    translate(posXbol, x1,1);
    specular(255, 255, 255);
    //rotateX(rx);
    //rotateY(ry);
    sphere(r);
    popStyle();
    
    //rx = rx + 0.01;
    //ry = ry + va;
    
    //Bolita (circulo):
    //circle(posXbol, x1, db);
    
    x1=senalArd.read();
    
    //---Simulacion sin arduino---//
    /* x1 = x1 + va;
    
    if(x1<tope_s){
      va=5;
      
    }
    if(x1>tope_i){
      va=-5;
      
    }
  //---Fin simulacion sin arduino---//*/
 
 //probar
  }
  delay(100);
}
