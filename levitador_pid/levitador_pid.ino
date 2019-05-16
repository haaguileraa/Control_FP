#include "TimerOne.h"

//Pines de los Potenciometros
float pin_ki = A0;
float pin_kp = A1;
float pin_r  = A2;

//--------Constantes de la planta---------//

float u = 0;  //Ventilador
float ro = 1.223; //Densidad del aire seco
float Cd = 0.5;   //Coeficiente aerodinamico de la esfera.
float alpha = Cd * ro / 2; //Constante de presión del aire
float tao = 0.1;  //Constante motor
float k = 1;    //Constante motor
float m = 0.4;  //Masa bola
float g = 9.8;  //Gravedad
float L = 10;   //Largo del tubo

//Planta
float x1, x2, Va = 0;
float dx1, dx2, dVa;
int Van;



// constantes del PID
//Variable timer
int Fs = 1000; //Frecuencia de Operación
float D = (float)1 / Fs;  //Tiempo de muestreo
long Ts = 1000000 / Fs;   //Tiempo del timer 5ms
int n = 0;    //Variable para cambiar la referencia
float r = 0;//L/2;  //Referencia
float e = 0;  //Error
//Control proporcional
float kp = 2;//2;
float P = 0;
//Control integral
float ki = 1;//1;
float kib = ki * D;
float I = 0, Iant = 0;
float alt =0;

void setup() {
  Serial.begin(2000000);
  // timer para ajustar la interrupcion
  Timer1.initialize(Ts);
  Timer1.attachInterrupt(control);
}

void control()
{
  //-------Con potenciometro-------//
  alt= analogRead(pin_r)/102.3; 
  ki = 10-analogRead(pin_ki)/102.3;
  kp = 10-analogRead(pin_kp)/102.3;
  n += 1;
  if (n % 1500 == 0) {//2500 == 0) {
   if (r < (L-alt)) {
      r = L-alt;
    }
    else
      r = 0;
  } // */

 
/*
Serial.print(ki); //
Serial.print(" "); //
Serial.println(kp); //
//Serial.print(alt); //
Serial.print(" "); //
Serial.println(r); //*/
  // Control
  e = r - x1;
  P = kp * e;
  I = Iant + kib * e;
  u = P + I;
  if (u>12) u=12;
  Iant = I;

  Van=(Va - x2);
  dx1 = D*x2 + x1;
  dx2 = D*alpha / m * sq(Van) - D*g + x2;
  dVa = -D / tao * Va + D* k / tao * u + Va;
  
  x1 = dx1;
  x2 = dx2;
  Va = dVa;

  if(x1<0){
    x1=0;
    x2=0;
  }
    
    Serial.print(x1);
    Serial.print(" ");
    Serial.print(r);
    Serial.print(" "); 
    Serial.print(kp);
    Serial.print(" ");
    Serial.println(ki); //*/
    //Serial.println(r);
    //Serial.println(x1);
}
void loop() {
 
}
