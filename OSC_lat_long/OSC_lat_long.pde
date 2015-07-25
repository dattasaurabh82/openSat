/**************** Map libraries (usong unfolding for processing) ****************/
import de.fhpotsdam.unfolding.mapdisplay.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.interactions.*;
import de.fhpotsdam.unfolding.ui.*;
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.mapdisplay.shaders.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.texture.*;
import de.fhpotsdam.unfolding.events.*;
import de.fhpotsdam.utils.*;
import de.fhpotsdam.unfolding.providers.*;
/*********************************************************************************/


/*********** OSC libraries ***********/
import oscP5.*;
import netP5.*;
/*************************************/

/*********** UI Libraries *************/
import controlP5.*;
/**************************************/


/**** Declarations regarding OSC ****/
OscP5 oscP5;
NetAddress myRemoteLocation;
float lat;
float l0ng;
String srcIP = "127.0.0.1";
int incomingPort = 8000;
/************************************/

/***** Unfolding call for map method *****/
UnfoldingMap map;
DebugDisplay debugDisplay;
/*****************************************/

/******* Declarations for UI methods *******/
ControlP5 cp5;
Textarea myTextarea;
int c = 0;
Println console;

int zoomLevel = 2;
/*******************************************/


PFont f;
void setup() {
  size(1020, 1010, P2D);

  /***************** OSC setup ***************************/
  oscP5 = new OscP5(this, 8000);
  myRemoteLocation = new NetAddress(srcIP, incomingPort);


  /****************** Unfolding Map Setup *********************/
  map = new UnfoldingMap(this, new StamenMapProvider.Toner());
  map.zoomToLevel(2);
  //map.zoomAndPanTo(new Location(52.5f, 13.4f), 10);
  MapUtils.createDefaultEventDispatcher(this, map);
  // Create debug display (optional: specify position and size)
  debugDisplay = new DebugDisplay(this, map);

  //creating the font
  f = loadFont("Consolas-12.vlw");
  textFont(f);

  /***************** control p% UI setup *********************/
  cp5 = new ControlP5(this);
  cp5.enableShortcuts();
  myTextarea = cp5.addTextarea("txt")
    .setPosition(15, 200)
      .setSize(200, 60)
        .setFont(createFont("", 10))
          .setLineHeight(14)
            .setColor(color(200))
              .setColorBackground(color(255, 10))
                .setColorForeground(color(0, 255, 0, 200));
  ;

  console = cp5.addConsole(myTextarea);

  cp5.addSlider("zoomLevel")
    .setPosition(10, 250)
      .setSize(160, 15)
        .setRange(0, 10)
          ;
}

float newPosX = 500;
float newPosY = 500;
float posX, posY;

void draw() {
  background(0);  
  map.draw();
  debugDisplay.draw();
  map.zoomToLevel(zoomLevel);
  mapActions();
}

void mapActions() {
  //Location locationISS = new Location(52.5f, 13.4f);
  Location locationISS = new Location(lat, l0ng);
  // Fixed-size marker
  ScreenPosition posISS = map.getScreenPosition(locationISS);
  posX = posISS.x;
  posY = posISS.y;
  //marker
  fill(45, 189, 240, 120);
  smooth();
  stroke(255, 0, 0, 100);
  strokeWeight(3);
  ellipse(posX, posY, 20, 20);

  // bounding boxes for lat lang
  fill(200, 0, 0, 210);
  noStroke();
  rect(posX+20, posY-10, 100, 20);
  rect(posX-50, posY-40, 100, 20);

  //textual display of lat lang on the canvas
  fill(255);
  text("Lat: " + lat, posX+30, posY+4);
  text("Lon: " + l0ng, posX-40, posY-26);
}

void oscEvent(OscMessage theOscMessage) {
  lat = theOscMessage.get(0).floatValue();
  l0ng = theOscMessage.get(1).floatValue();

  println(" Lat: " + lat + "  Long: " + l0ng);
} 

