import controlP5.*;
ControlP5 gui;
Button next, options; //Modes
Button myAccount, Doctor, Recap, Home;
Button reset, send;
public void createButtons() {
  gui = new ControlP5(this);
  PFont font = createFont("Times-Italic", 15);  
  next = gui.addButton("Save")
    .setPosition(550, 550)
    .setColorBackground(color(0, 0, 150))
    .setSize(50, 50)
    .setFont(font)
    //.setValue(0)
    //.activateBy(ControlP5.RELEASE)
    .show()
    ;
  PImage opt = loadImage("option.PNG");
  opt.resize(0, 40);
  options = gui.addButton("Option")
    .setPosition(0, -2)
    .setImage(opt)
    .updateSize()
    .hide()
    ;
  int BgrpX = 5;
  myAccount = gui.addButton("Account")
    .setPosition(BgrpX, 40)
    .setColorBackground(color(0, 0, 150))
    .setSize(90, 50)
    .setFont(font)
    //.setValue(0)
    //.activateBy(ControlP5.RELEASE)
    .hide()
    ;  
  Recap = gui.addButton("Recap")
    .setPosition(BgrpX, 100)
    .setColorBackground(color(0, 0, 150))
    .setSize(90, 50)
    .setFont(font)
    //.setValue(0)
    //.activateBy(ControlP5.RELEASE)
    .hide()
    ;
  Doctor = gui.addButton("Doctor")
    .setPosition(BgrpX, 160)
    .setColorBackground(color(0, 0, 150))
    .setSize(90, 50)
    .setFont(font)
    //.setValue(0)
    //.activateBy(ControlP5.RELEASE)
    .hide()
    ;
  reset = gui.addButton("Reset")
    .setPosition(250, 500)
    .setColorBackground(color(150, 0, 0))
    .setSize(100, 50)
    .setFont(font)
    //.setValue(0)
    //.activateBy(ControlP5.RELEASE)
    .hide()
    ;
    send = gui.addButton("Send")
    .setPosition(250, 500)
    .setColorBackground(color(0, 0, 150))
    .setSize(100, 50)
    .setFont(font)
    //.setValue(0)
    //.activateBy(ControlP5.RELEASE)
    .hide()
    ;
    Home = gui.addButton("Home")
    .setPosition(0, 550)
    .setColorBackground(color(0, 0, 150))
    .setSize(48, 50)
    .setFont(font)
    //.setValue(0)
    //.activateBy(ControlP5.RELEASE)
    .hide()
    ;
}

public void Save(int value) {
  next.hide();
  options.show();

  input = false;
  main = true;
  doctorNote = false;
  Home.hide();
  inputs.setVisible(false);
}
public void Option(int value) {
  showOptions = !showOptions;
  if (showOptions) {
    Doctor.show();
    Recap.show();
    myAccount.show();
  } else {
    Doctor.hide();
    Recap.hide();
    myAccount.hide();
  }
}  

public void Account(int value) {
  next.show();
  options.show();
  send.hide();

  input = true;
  main = false;
  doctorNote = false;
  Home.show();

  inputs.setVisible(true);
  Doctor.hide();
  Recap.hide();
  myAccount.hide();
  reset.hide();
  showOptions = false;
}
public void Recap(int value) {
  next.hide();
  options.show();
  reset.show();
  send.hide();
  input = false;
  main = false;
  recap = true;
  doctorNote = false;
  Home.show();

  inputs.setVisible(false);
  Doctor.hide();
  Recap.hide();
  myAccount.hide();
  showOptions = false;
}

public void Doctor(int value){
    next.hide();
  options.show();
  reset.show();
    input = false;
  main = false;
  recap = false;
  doctorNote = true;
  Home.show();


  inputs.setVisible(false);
  Doctor.hide();
  Recap.hide();
  myAccount.hide();
  showOptions = false;
  reset.hide();
  send.show();
}
public void Home(int value){
  next.hide();
  options.show();
  send.hide();
  Home.hide();
  
  input = false;
  main = true;
  doctorNote = false;

  inputs.setVisible(false);
  Doctor.hide();
  Recap.hide();
  myAccount.hide();
  reset.hide();
  showOptions = false;
  
  
}
public void Send(int value){
  
  send.hide();

  
}
public void Reset(int value) {
  sCount =0; 
  meanV=0; 
  km=0; 
  balanceEff=0; 
  
}
