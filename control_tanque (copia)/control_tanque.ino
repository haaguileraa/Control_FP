
#include "TimerOne.h"


// constantes del PID


float u=0;
float h=0, hn=0;
int n=0;
int Fs = 200;
float D = (float)1/Fs;
long Ts =1000000/Fs; 
float A = 3.14;
float a = .5;
float b = 1;
float p1 = -D*a/A ;
float p2 = D*b/A;
float r = 1;
float I=0, Iant=0;
float eant=0;
float DE=0;
float kp = 2;
float ki = 5;
float kd = 1;
float kib = ki*D;
float kdb = kd/D;
float e = 0;

float P=0;
// filtro diseñado para wp = 0.1 en frecuencia normalizada 

void setup() {
   Serial.begin(2000000);
    while (!Serial) {
    ; // wait for serial port to connect. Needed for Leonardo only
    }
    // timer para ajustar la interrupcion
    Timer1.initialize(Ts);        
    Timer1.attachInterrupt(control);

}




void control()
{
    n+=1;

   if (n % 2500==0){
    if (r <2){
      r = 2;
    }
    else
      r = 1;
   } 
    // Control 
      
    
    e = r-h;
    P = kp*e;
    I = Iant+kib*e;
    DE = kdb*(e-eant);
    u = P+I+DE; //P+I;
    
    Iant = I; 
    eant = e; 
    
    // planta en lazo abierto
   
    hn = h + p1*sqrt(h) + p2*u; 
    h = hn;
 
if (n % 5==0){

Serial.print(r,3);
Serial.print('\t');
Serial.println(h,3);
} 

}




// main loop no hace nada
void loop(){
  }
