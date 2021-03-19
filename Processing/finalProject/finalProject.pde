/**
 This sketch is to demonstrate some features of the GPassword, 
 GTextField and GTextArea controls. 
 
 These features include
 - Tabbing between controls
 - Hidden text in password control between controls
 - Default text
 - Copy and paste text
 
 for Processing V2 and V3
 (c) 2015 Peter Lager
 
 */

import g4p_controls.*;
GTextArea txa1, txa2;
GPassword pwd1;
GTabManager tt;
GLabel lblPwd;



boolean input = true, main = false, doctorNote = false, recap=false;
PImage logo, sock, barcode;
boolean showOptions = false;
float sCount =0, meanV=0, km=0, balanceEff=0; 
float HR = 0, temp = 0, DVT=0, falling=0;
String[] status = {"Normal", "Critical", "Expectacular"};
int stat = 0;
GGroup inputs, mains, doctorNotes;

//Serial Communication
import processing.serial.*;
Serial mySerial;
String myString = null;


public void setup() {
  size(600, 600);
  logo = loadImage("logo.jpeg");
  logo.resize(0, 40);
  sock = loadImage("sock.png");
  sock.resize(0, 450);  
  barcode = loadImage("barcode.jpeg");
  barcode.resize(0, 35);

  createButtons();


  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  // Some start text
  String startTextF = "G4P is a GUI control library created by Peter Lager";

  createFirstPage();
  println(Serial.list());
  mySerial = new Serial(this, "COM3", 19200); // Change to the port your arduino is connected (i.e. "COM1"...."COM2"..."COM3".... ect)
  mySerial.bufferUntil('\n'); //clean the buffer
}

public void draw() {

  background(250, 250, 250);
  fill(10, 0, 10);
  textSize(25);
  text("Welcome to ", 180, 25);
  image(logo, 330, -3);
  textSize(8);
  text("Web Link:", 520, 30);
  image(barcode, 560, 0);

  stroke(0);
  line(0, 35, 600, 35);

  if (input) {
    sketchFirstPage();
  } 
  //
  /////>>>>> MAIN SCREEN 
  //
  else if (main) {
    textSize(18);
    fill(10, 10, 100);
    text("Hi, "+Name, 200, 52);

    image(sock, 55, 90);
    stroke(0);
    line( 125, 150, 305, 120);
    line(105, 220, 305, 220);
    //line( 100,500, 305,420);
    //line(110,520, 305,520);
    drawMainText();
    drawMainAlerts();
  } 
  //
  /////>>>>> DOCTOR NOTE 
  //
  else if ( doctorNote ) {
    textSize(15);
    fill(10, 10, 100);
    text("Hello Dr. "+ dr, 60, 80);

    textSize(12);
    text("The Recap for patient "+Name+" is as follows:\n"
      + "According to our evaluations the overall health status is " + status[stat]+" \nKeeping normal temperature and HearRate."
      + "\nPatient has done "+int(sCount)+ " steps in the past " + hgoal+" hours.\n"
      , 80, 120); 

    String txt = "Name:\nOverall Status:\nStep Count:\n";
    String res = Name + "\n" + status[stat] + "\n" + int(sCount);
    fill(0, 0, 100);
    textSize(15);
    text(txt, 80, 260);
    fill(100, 0, 0);
    text(res, 220, 260);

    if (!send.isVisible()) {
      fill(10, 10, 100);
      rect(250, 500, 100, 50);
      fill(240, 240, 240);
      textSize(15);
      text("Email Sent", 260, 530);
    }
  } 
  //
  /////>>>>> RECAP 
  //
  else if ( recap ) {

    drawRecapText();
  }  
  //if first page is gone
  if (!input) {
    noFill();
    stroke(0, 0, 0);
    rect(50, 60, 500, 530, 5);
  }
  //show options field
  if (showOptions) {
    fill(255, 255, 255);  
    stroke(0, 0, 100);
    rect(0, 35, 100, 180, 7);
    fill(0, 0, 100, 100);
    rect(0, 0, 40, 35);
  }
}

// Handles events from checkbox and option controls.
public void handleToggleControlEvents(GToggleControl checkbox, GEvent event) {
  println(checkbox.tagNo);
  switch(checkbox.tagNo) {
  case 1:
    gender = true;
    break;
  case 2:
    gender = false;
    break;
    //case 10:
    //  subscription = true;
    //  break;
    //case 11: 
    //  subscription = false;
    //  break;
  }
}

float[] splice = {0, 0, 0, 0, 0, 0, 0, 0};

void serialEvent( Serial mySerial) {
  try {
    if (mySerial.available() > 0)
    {
      myString = mySerial.readStringUntil('\n');
      if (myString != null)
      {
        println(myString);
        myString = trim(myString);
        float[] s = float(split(myString, ','));
        for (int i =0; i < s.length; i++)
          splice[i] = s[i];

        HR = splice[0];
        temp = splice[1];
        sCount = splice[2];
        km = splice[3];
        meanV = splice[4];
        DVT = splice[5];
        balanceEff = splice[6];
        falling = splice[7];
      }
    }
  }
  catch(RuntimeException e) {
    e.printStackTrace();
  }
}

////DISPLAY EVENTS HAPPENING TO TEXT FIELDS
//public void displayEvent(String name, GEvent event) {
//  String extra = " event fired at " + millis() / 1000.0 + "s";
//  print(name + "   ");
//  switch(event) {
//  case CHANGED:
//    println("CHANGED " + extra);
//    break;
//  case SELECTION_CHANGED:
//    println("SELECTION_CHANGED " + extra);
//    break;
//  case LOST_FOCUS:
//    println("LOST_FOCUS " + extra);
//    break;
//  case GETS_FOCUS:
//    println("GETS_FOCUS " + extra);
//    break;
//  case ENTERED:
//    println("ENTERED " + extra);  
//    break;
//  default:
//    println("UNKNOWN " + extra);
//  }
//}
//
//public void handleTextEvents(GEditableTextControl textControl, GEvent event) { 
//  displayEvent(textControl.tag, event);
//}

//public void handlePasswordEvents(GPassword pwordControl, GEvent event) {
//  displayEvent(pwordControl.tag, event);
//}
