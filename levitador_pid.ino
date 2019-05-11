
#include "TimerOne.h"


// constantes de la planta

float cd = 0.8;
float rho = 1.225;
float radio = 3/1000;
float m = 0.4/1000;
float g = 9.8;
float Area = 3.14*radio*radio;

float alpha = 0.5*cd*rho*Area;
float pp = alpha/m;

// constantes del PID

int n = 0;
float u=0;
float hant=0, h=0, hn=0, hn2=0;
int Fs = 200;
float D = (float)1/Fs;
long Ts =1000000/Fs; 
float A = 3.14;
float I=0, Iant=0;
float eant=0;
float DE=0;
float r = 1;
float kp = 2000;
float ki = 5000;
float kd = 2000;
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
    hn = h/(3.14*Fs) - hant/(3.14*Fs);
    h = hant;
    hn2 =  hn + pp*((u-hn)*(u-hn))/(3.14*Fs) -g/(3.14*Fs); 
    hn = hn2;
 
 if (n % 5==0){

Serial.print(r,3);
Serial.print('\t');
Serial.println(hn,3);
} 

}




// main loop no hace nada
void loop(){
  }
