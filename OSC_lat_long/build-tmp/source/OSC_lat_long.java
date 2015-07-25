import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import oscP5.*; 
import netP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class OSC_lat_long extends PApplet {



  
OscP5 oscP5;
NetAddress myRemoteLocation;

int oscMsg;
String srcIP = "127.0.0.1";
int incomingPort = 8000;

public void setup() {
  size(400,400);
  frameRate(25);
  
  oscP5 = new OscP5(this, 8000);
  myRemoteLocation = new NetAddress(srcIP, incomingPort);
}


public void draw() {
  background(0);  
  fill(255);
  text(oscMsg, (width/2)-20, (height/2)-10);
}

public void oscEvent(OscMessage theOscMessage) {
  oscMsg = theOscMessage.get(0).intValue();
  println(" OSC msg: "+ oscMsg);
} 
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "OSC_lat_long" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
