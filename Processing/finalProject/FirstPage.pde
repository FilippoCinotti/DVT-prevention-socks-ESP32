GTextField fname, lname, age, Weight, Height, email, Dr;
GTextField phNumber, phNumber1, phNumber2, phNumber3;
GTextField stepGoal, hourGoal;  
int textY= 100, textX = 50;


String Name = "Unknown", dr = "N/A", em = "N/A";
int a = 23, weight = 150;
String n = "(800) 555-9090";
double h = 5.8;
String[] PhoneNumbers = {n, "0000000000", "0000000000", "0000000000"};
boolean gender = true; //Male true, Female false
boolean subscription = false;
int sgoal=8000, hgoal = 24;

GOption m, f;
GToggleGroup mfo;

public void createFirstPage() {  

  fname = new GTextField(this, textX, textY+20, 150, 20);
  fname.tag = "firstName";
  fname.setPromptText("  First Name: "); 

  lname = new GTextField(this, textX, textY+45, 150, 20);
  lname.tag = "lastName";
  lname.setPromptText("  Last Name: ");

  mfo = new GToggleGroup();
  m = new GOption(this, textX+180, textY+20, 94, 18);
  m.setText("male");
  m.tagNo = 1; 
  f = new GOption(this, textX+180, textY+40, 94, 18);
  f.setText("female");
  f.tagNo = 2;
  mfo.addControl(m);
  mfo.addControl(f);

  age = new GTextField(this, textX, textY+90, 120, 20);
  age.tag = "age";
  age.setPromptText("  Age: ");


  Weight = new GTextField(this, textX, textY+135, 120, 20);
  Weight.tag = "Weight";
  Weight.setPromptText("  weight (lb): ");


  Height = new GTextField(this, textX, textY+180, 120, 20);
  Height.tag = "Height";
  Height.setPromptText("  Height (Ft.in): ");

  phNumber = new GTextField(this, textX, textY+225, 120, 20);
  phNumber.tag = "Phone";
  phNumber.setPromptText(" (000) 000-0000 ");

  phNumber1 = new GTextField(this, textX, textY+265, 120, 20);
  phNumber2 = new GTextField(this, textX, textY+290, 120, 20);
  phNumber3 = new GTextField(this, textX, textY+315, 120, 20);

  email = new GTextField(this, textX, textY+355, 120, 20);
  email.tag = "email";
  email.setPromptText(" aaa@mail.com ");

  Dr = new GTextField(this, textX, textY+395, 120, 20);
  Dr.tag = "Dr";
  Dr.setPromptText("Dr.Joe Kulik ");

  stepGoal = new GTextField(this, textX+300, textY+200, 120, 20);
  stepGoal.tag = "stepGoal";
  stepGoal.setPromptText(str(sgoal) + " steps");
  hourGoal = new GTextField(this, textX+300, textY+250, 120, 20);
  hourGoal.tag = "hourGoal";
  hourGoal.setPromptText(str(hgoal) + " Hrs");


  fname.setFocus(false);
  // Create the tab manager and add these controls to it
  //tt = new GTabManager();
  inputs = new GGroup(this);
  inputs.addControls(fname, lname, age, Weight, Height);
  inputs.addControls(phNumber, phNumber1, phNumber2, phNumber3);
  inputs.addControls(email, Dr, m, f, stepGoal, hourGoal);
}


public void sketchFirstPage() {


  fill(10, 10, 150);
  textSize(15);
  text("Let Us know a little about you:", textX-10, textY-25);

  stroke(0);
  strokeWeight(2);
  //line(fname.getCX()/2, fname.getCY(), txa1.getCX()/2, lblPwd.getY());
  //line(fname.getCX()/2, pwd1.getCY(), txa1.getCX()/2, txa1.getCY());

  //line(txa1.getCX(), txa1.getCY(), lname.getCX(), lname.getCY());
  //line(lname.getCX(), lname.getCY(), txa2.getCX(), txa2.getCY());
  //if(pwd1.getPassword().length() == 0)
  //lblPwd.setText("Enter password below");
  //else
  //lblPwd.setText(pwd1.getPassword());

  fill(0, 0, 0);
  textSize(12);
  text("Full Name:", textX-5, textY+15);      
  text("Age:", textX-5, textY+85);
  text("Weight:", textX-5, textY+130);
  text("Height:", textX-5, textY+175);
  text("Primary Phone Number:", textX-5, textY+220);
  text("Emergency Phone Numbers:", textX-5, textY+260);
  text("Email:", textX-5, textY+350);
  text("Doctor:", textX-5, textY+390);
  line(textX-10, textY-20, textX-10, textY+430);
  fill(10, 10, 150);
  textSize(15);
  text("Set Goals:  ", textX+285, textY+165);

  fill(0, 0, 0);
  textSize(12);
  text("Step Count", textX+290, textY+195);
  text("Per ___ Hours", textX+290, textY+245);
  line(textX+280, textY+170, textX+280, textY+290);
  String stpC = stepGoal.getText();
  String hrC = hourGoal.getText();
  if (stepGoal.getText() != "")
    sgoal = int(stpC);
  if (hourGoal.getText() != "")
    hgoal = int(hrC);

  if (fname.getText() != "" || lname.getText() != "")
    Name = fname.getText() + " " + lname.getText();
  if (age.getText()!="")
    a = int(age.getText());
  if (Weight.getText()!="")
    weight = int(Weight.getText());
  if (Height.getText()!="")
  {
    String hs = Height.getText();
    h = float(hs);
  }
  if (phNumber.getText() != "")
    PhoneNumbers[0] = phNumber.getText();
  if (phNumber1.getText() != "")
    PhoneNumbers[1] = phNumber1.getText();
  if (phNumber2.getText() != "")
    PhoneNumbers[2] = phNumber2.getText();
  if (phNumber3.getText() != "")
    PhoneNumbers[3] = phNumber3.getText();
  if (Dr.getText() != "")
    dr = Dr.getText();
  if (email.getText()!="")
    em = email.getText();
}
