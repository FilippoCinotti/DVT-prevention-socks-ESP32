///////////////
//draw main texts

public void drawMainText() {

  textSize(18);
  fill(0, 0, 0);
  text("Heart Rate", 305, 90);
  noFill();
  stroke(0);
  rect(305, 100, 150, 40, 5);
  fill(100, 240, 250);
  text(int(HR), 360, 125);    

  fill(0, 0, 0);
  text("Body Temperature", 305, 190);
  noFill();
  stroke(0);
  rect(305, 200, 150, 40, 5);
  fill(100, 240, 250);
  text(int(temp) + " f", 360, 225);

  fill(0, 0, 0);
  text("Step Count", 305, 390);
  noFill();
  stroke(0);
  rect(305, 400, 150, 40, 5);
  fill(100, 240, 250);
  text(int(sCount), 360, 425);

  fill(0, 0, 0);
  text("Km Count", 305, 490);
  noFill();
  stroke(0);
  rect(305, 500, 150, 40, 5);
  fill(100, 240, 250);
  text(km + " km", 360, 525);
}

//initialize colors
int i =0;
color red = color(200, 0, 0);
color gr = color(0, 200, 0);
color or = color(255, 150, 21);
//use colors to build circles
public void drawMainAlerts() {
  noStroke();

  if (DVT == 1) {
    fill(260-i*3, 100+i*3, i);
    
    ellipse(125, 150, 40, 40);
    ellipse(105, 220, 40, 40);
    ellipse(78, 413, 40, 40);
    ellipse(130, 500, 40, 40);
    i++;
    if (i>20) i = 0;
  } else {
    fill(gr);
    if (HR == 0)
      fill(red);
    ellipse(125, 150, 40, 40);
    fill(gr);
    if (temp == 0)
      fill(red);      
    ellipse(105, 220, 40, 40);
    fill(gr);
    ellipse(78, 413, 40, 40);
    fill(gr);
    ellipse(130, 500, 40, 40);
  }
  
  int x = 70, y = 580;
  //Color description
  textSize(10);
  fill(0);
  text("offline", x+8, y);
  fill(red);
  ellipse(x, y, 10, 10); 
  textSize(10);
  fill(0);
  text("online", x+58, y);
  fill(gr);
  ellipse(x+50, y, 10, 10); 
  textSize(10);
  fill(0);
  text("DVT Alert", x+108, y);
  fill(or);
  ellipse(x+100, y, 10, 10); 

  //if falling
  if (falling == 1) {
    fill(red);
    textSize(18);
    text("<<<FALLING>>>", 305, 310);
  }
}




/////////////////////
//Draw values for recap screen

public void drawRecapText() {

  float percentage = (sCount/sgoal);
  fill(100, 240, 250);
  noStroke();
  arc(450, 150, 100, 100, 0, 2* percentage * PI, PIE);
  textSize(12);
  fill(0, 0, 200);
  text(int(percentage*100) + "% to Goal", 410, 150);

  textSize(20);
  text("Daily Activity", 55, 82);

  textSize(18);
  fill(0, 0, 0);
  text("Step Counter", 100, 130);
  noFill();
  stroke(0);
  rect(100, 140, 150, 40, 5);
  fill(100, 240, 250);
  text(int(sCount), 140, 165);

  textSize(18);
  fill(0, 0, 0);
  text("Distance", 100, 230);
  noFill();
  stroke(0);
  rect(100, 240, 150, 40, 5);
  fill(100, 240, 250);
  text(km + "km", 140, 265);


  textSize(18);
  fill(0, 0, 0);
  text("Mean Velocity", 100, 330);
  noFill();
  stroke(0);
  rect(100, 340, 150, 40, 5);
  fill(100, 240, 250);
  text(meanV, 140, 365);


  textSize(18);
  fill(0, 0, 0);
  text("Balance Efficiency", 100, 430);
  noFill();
  stroke(0);
  rect(100, 440, 150, 40, 5);
  fill(100, 240, 250);
  text(balanceEff, 140, 465);
}
