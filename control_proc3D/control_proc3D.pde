import processing.serial.*;
import grafica.*;
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

float x1 = 0;// L/2+posY;  //510 abajo, 300: centro  //Se obtiene de arduino
int va = -5;
float rx  = 0;
float ry  = 0;
//---valores para animar sin entrada de arduino---/
int tope_s = posY+db/2+5,  //+10 para que no se salga de la probeta
    tope_i = posY+L-(db/2+3);
//---valores para animar con entrada de arduino---/
Serial senalArd;

//Nuestra mitad de la probeta 
float half = L/2+posY; //= 225;
float erre =0,
      inByte =0;


//---Para el BOX de los valores

int ancho  = 182 ,
    alto   = 40;









////////
//---------------SETUP------------------//
void setup() {
  //ventana
  size(700, 700, P3D);
  ///*
  //Arduino: 
  String puerto ="/dev/ttyACM0";  //Cambiar por el puerto en el que esté el arduino
  //print(puerto);
  senalArd= new Serial(this, puerto, 2000000); //tercer argumento = baudios.*/
  senalArd.bufferUntil('\n');
}

void draw() {
  background(220,220,220);
  inByte =L- erre*45 + posY;//+half;
     
   /* */
      
      if(inByte>=0){
        x1 = inByte;      
        
    //x1=100;
      }
      if(inByte<tope_s) {
        x1 = tope_s;
      
      }//
      if(inByte>tope_i) {
        x1 = tope_i;
      
      }// */

    //x1 = senalArd.read();
    //x1=inByte;
    println(x1);
   println(erre);
   println(tope_i);
    
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
    
     //----------TEXTO----------//
    
    pushStyle(); //new style
    textSize(32);
    //fill(0, 0, 0);
    translate(0,0);
    rect(posX+200, posY, ancho, alto);
    fill(0, 0, 0);
    text("X1:", posX+210, posY+30);
    textLeading(10);
    text(erre, posX+260, posY+30);       
    popStyle(); //original style
   
    pushStyle(); //new style
    textSize(32);
    //fill(0, 0, 0);
    translate(0,0);
    rect(posX+200, posY+70, ancho, alto);
    fill(0, 0, 0);
    text("r:", posX+210, posY+100);
    textLeading(1);
    text(erre, posX+260, posY+100);
    popStyle(); //original style
 
    
    
    
    
    
    //Debe ir de ultimo por el "translate"
    
    //--------BOLITA-----------//
    pushStyle();
    noStroke();
    fill(0, 51, 102);
    lightSpecular(255, 255, 255);
    directionalLight(0, 10, 0, 0, 0, -10);
    translate(posXbol, x1,1);
    specular(255, 255, 255);
    sphere(r);
    popStyle();
    
  
   
    
}

//Serial event
void serialEvent (Serial senalArd ){
 erre = float(senalArd.readStringUntil('\n')); 
/*
|int lf = 10;
    // Expand array size to the number of bytes you expect:
    byte[] inBuffer = new byte[7];
    senalArd.readBytesUntil(lf, inBuffer);
    if (inBuffer != null) {
      String myString = new String(inBuffer);
      //println(myString);
      float inByte = float(myString) ;
*/ //Este Buffer iría en el comienzo del void draw() pero lo hace muy lento.
//Esto y todo lo comentado va arriba

//---Simulacion sin arduino---//
    /* x1 = x1 + va;
    
    if(x1<tope_s){
      va=5;
      
    }
    if(x1>tope_i){
      va=-5;
      
    }
  //---Fin simulacion sin arduino---//*/

}
