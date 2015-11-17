import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import processing.serial.*;

import cc.arduino.*;
 
Arduino arduino;

int val;            // variable to receive data from the serial port
boolean firstTime = true;

Capture cam;
OpenCV opencv;

int msec, sec;
boolean start;
int valueR = 0;
int valueG = 0;
int valueB = 0;
int stock = 0;
float XPOSB=0;
float YPOSB=0;


void setup() {
  
size(640, 480);


    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this,640/2, 480/2);
    cam.start();     
    opencv = new OpenCV(this, 640/2, 480/2); 

 
     
opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);


  println(Arduino.list());

  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(9, Arduino.SERVO);
  arduino.pinMode(10, Arduino.SERVO);
  }


void draw() {
  
  background(255);

 

scale(2);

 
opencv.loadImage(cam);
image(cam, 0, 0 );
noFill();
strokeWeight(3);
Rectangle[] faces = opencv.detect();
//println(faces.length);

if (firstTime) {
    delay(3000);
    firstTime = false;
  }
     //port.write(50);    // writes the angle to the serial port

  arduino.servoWrite(9, 50);
  arduino.servoWrite(10, 90);


for (int i = 0; i < faces.length; i++) 
{
   float XPOS=faces[i].x;
   float YPOS=faces[i].y;


   rect(XPOS, YPOS, faces[i].width, faces[i].height);
   stroke(valueR, valueG, valueB);
   println("XPOS:"+XPOS);

   //port.write(0);    // writes the angle to the serial port


  arduino.servoWrite(9, 0);
  arduino.servoWrite(10, 0);

  
  
 


}
    }
 
 

     







void captureEvent(Capture cam) {
cam.read();
}
