//terms for PPG
int PPGDATA = A4;
int HeartBeat = 0;
float ppgdata = 0, thresh = 52500, HRV = 0, HR = 0;
unsigned long Rcurrent = 0, Tcurrent = 0, Ptime = 0;
bool inrange = false;

//terms for temperature sensor
int TempPin = A5; 
long rawTemp;
float voltage;
float fahrenheit;
float celsius;

//terms for Foot pressure
int pressa=A2, pressp=A1; 
int fs1, fs2;
float count = 0, contabad=0;
int thresh_high = 80;
int thresh_low = 15;
int bottomThresh = 700, fs1tot = 0, fs2tot = 0, cont = 0;
float distance, walkspeed, steplength = 1.5, Acttime, old_y, old_z, zdirec, BE;
int fs1new, fs2new;
bool stepping=true;

//terms for MPU
//#include "I2Cdev.h"
//#include "MPU6050_6Axis_MotionApps20.h"
//#if I2CDEV_IMPLEMENTATION == I2CDEV_ARDUINO_WIRE
//#include "Wire.h"
//#endif
//MPU6050 mpu;
//#define OUTPUT_READABLE_YAWPITCHROLL
//#define OUTPUT_READABLE_WORLDACCEL
//#define INTERRUPT_PIN 2  // use pin 2 on Arduino Uno & most boards
//#define LED_PIN 13 // (Arduino is 13, Teensy is 11, Teensy++ is 6)
//bool blinkState = false;
//bool dmpReady = false;  // set true if DMP init was successful
//uint8_t mpuIntStatus;   // holds actual interrupt status byte from MPU
//uint8_t devStatus;      // return status after each device operation (0 = success, !0 = error)
//uint16_t packetSize;    // expected DMP packet size (default is 42 bytes)
//uint16_t fifoCount;     // count of all bytes currently in FIFO
//uint8_t fifoBuffer[64]; // FIFO storage buffer
//Quaternion q;           // [w, x, y, z]         quaternion container
//VectorInt16 aa;         // [x, y, z]            accel sensor measurements
//VectorInt16 aaReal;     // [x, y, z]            gravity-free accel sensor measurements
//VectorInt16 aaWorld;    // [x, y, z]            world-frame accel sensor measurements
//VectorFloat gravity;    // [x, y, z]            gravity vector
//float euler[3];         // [psi, theta, phi]    Euler angle container
//float ypr[3];           // [yaw, pitch, roll]   yaw/pitch/roll container and gravity vector
//uint8_t teapotPacket[14] = { '$', 0x02, 0,0, 0,0, 0,0, 0,0, 0x00, 0x00, '\r', '\n' };
//volatile bool mpuInterrupt = false;     // indicates whether MPU interrupt pin has gone high
//void dmpDataReady() {
//    mpuInterrupt = true;
//}

//Terms for leg volume
int pinVol = A0;
const float alpha = 0.125;
float average = 0;
double data_filtered[] = {0, 0, 0, 0, 0, 0, 0, 0};
const int n = 7;
int mean = 8, media=0, conta=0, somma=0;

unsigned long stretch, Stime=0;
unsigned long prevMax = 0, currMax = 0, prevMin = 1000000, currMin = 1000000, RESthresh = 0;
unsigned long dataprev ;
bool swelling=0,DVT=0, Oldfalling=0;


void setup() {
  // initialize the serial communication:
  Serial.begin(19200);
  pinMode(PPGDATA, INPUT);
  
  pinMode(TempPin, INPUT);

  pinMode(pressa, INPUT);
  pinMode(pressp, INPUT);
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);
  
//    #if I2CDEV_IMPLEMENTATION == I2CDEV_ARDUINO_WIRE
//    Wire.begin();
//    Wire.setClock(400000); // 400kHz I2C clock. Comment this line if having compilation difficulties
//    #elif I2CDEV_IMPLEMENTATION == I2CDEV_BUILTIN_FASTWIRE
//        Fastwire::setup(400, true);
//    #endif
//    while (!Serial);
//    Serial.println(F("Initializing I2C devices..."));
//    mpu.initialize();
//    pinMode(INTERRUPT_PIN, INPUT);
//
//    // verify connection
//    Serial.println(F("Testing device connections..."));
//    Serial.println(mpu.testConnection() ? F("MPU6050 connection successful") : F("MPU6050 connection failed"));
//
//    // wait for ready
//    Serial.println(F("\nSend any character to begin DMP programming and demo: "));
//    while (Serial.available() && Serial.read()); // empty buffer
//    while (!Serial.available());                 // wait for data
//    while (Serial.available() && Serial.read()); // empty buffer again
//
//    // load and configure the DMP
//    Serial.println(F("Initializing DMP..."));
//    devStatus = mpu.dmpInitialize();
//
//    // supply your own gyro offsets here, scaled for min sensitivity
//    mpu.setXGyroOffset(220);
//    mpu.setYGyroOffset(76);
//    mpu.setZGyroOffset(-85);
//    mpu.setZAccelOffset(1788); // 1688 factory default for my test chip
//
//    // make sure it worked (returns 0 if so)
//    if (devStatus == 0) {
//        // Calibration Time: generate offsets and calibrate our MPU6050
//        mpu.CalibrateAccel(6);
//        mpu.CalibrateGyro(6);
//        mpu.PrintActiveOffsets();
//        // turn on the DMP, now that it's ready
//        Serial.println(F("Enabling DMP..."));
//        mpu.setDMPEnabled(true);
//
//        // enable Arduino interrupt detection
//        Serial.print(F("Enabling interrupt detection (Arduino external interrupt "));
//        Serial.print(digitalPinToInterrupt(INTERRUPT_PIN));
//        Serial.println(F(")..."));
//        attachInterrupt(digitalPinToInterrupt(INTERRUPT_PIN), dmpDataReady, RISING);
//        mpuIntStatus = mpu.getIntStatus();
//
//        // set our DMP Ready flag so the main loop() function knows it's okay to use it
//        Serial.println(F("DMP ready! Waiting for first interrupt..."));
//        dmpReady = true;
//
//        // get expected DMP packet size for later comparison
//        packetSize = mpu.dmpGetFIFOPacketSize();
//    } else {
//        // ERROR!
//        // 1 = initial memory load failed
//        // 2 = DMP configuration updates failed
//        // (if it's going to break, usually the code will be 1)
//        Serial.print(F("DMP Initialization failed (code "));
//        Serial.print(devStatus);
//        Serial.println(F(")"));
//    }
//
//    // configure LED for output
//    pinMode(LED_PIN, OUTPUT);

  pinMode(pinVol, INPUT);
    
  Ptime = millis();
}

void loop() {

//PPG program (HR information)


  ppgdata = analogRead(PPGDATA);
  ppgdata = ppgdata * 100;
  delay(30);
  //Serial.println(ppgdata);
  if (ppgdata >= thresh) {
    if (inrange == false) {
      HeartBeat++;
      delay(50);
    }
    inrange = true;
   }
  else
  {
    inrange = false;
  }

  if (millis() - Ptime > 10000) {
    HR = 6 * HeartBeat;
    Ptime = millis();
    HeartBeat = 0;
  }

//END PPG program

// Temperature program

// Read the raw 0-1023 value of temperature into a variable.
  rawTemp = analogRead(TempPin);
// Calculate the voltage, based on that value.
// Multiply by maximum voltage (3.3V) and divide by maximum ADC value (1023).
// If you plan on using this with a LilyPad Simple Arduino on USB power, change to 4.2
voltage = rawTemp * (3.3 / 1023.0);
//Serial.print("Voltage: "); // Print voltage reading to serial monitor
//Serial.println(voltage);
// Calculate the celsius temperature, based on that voltage..
celsius = (voltage - 0.5) * 100; 
//Serial.print("Celsius: "); // Print celcius temp to serial monitor
//Serial.println(celsius);
// Use a common equation to convert celsius to Fahrenheit. F = C*9/5 + 32.
fahrenheit = (celsius * 9.0 / 5.0) + 32.0;
//Serial.print("Fahrenheit: "); // Print Fahrenheit temp to serial monitor
//Serial.println(fahrenheit); 
// Print a blank line
//Serial.println();       
// Wait 1 second between readings
//delay(1000);  

// END Temperature program

// MPU

//// if programming failed, don't try to do anything
//    if (!dmpReady) return;
//
//    // wait for MPU interrupt or extra packet(s) available
//    while (!mpuInterrupt && fifoCount < packetSize) {
//        if (mpuInterrupt && fifoCount < packetSize) {
//          // try to get out of the infinite loop 
//          fifoCount = mpu.getFIFOCount();
//        }  
//        // other program behavior stuff here
//        // .
//        // .
//        // .
//        // if you are really paranoid you can frequently test in between other
//        // stuff to see if mpuInterrupt is true, and if so, "break;" from the
//        // while() loop to immediately process the MPU data
//        // .
//        // .
//        // .
//    }
//
//    // reset interrupt flag and get INT_STATUS byte
//    mpuInterrupt = false;
//    mpuIntStatus = mpu.getIntStatus();
//
//    // get current FIFO count
//    fifoCount = mpu.getFIFOCount();
//  if(fifoCount < packetSize){
//          //Lets go back and wait for another interrupt. We shouldn't be here, we got an interrupt from another event
//      // This is blocking so don't do it   while (fifoCount < packetSize) fifoCount = mpu.getFIFOCount();
//  }
//    // check for overflow (this should never happen unless our code is too inefficient)
//    else if ((mpuIntStatus & _BV(MPU6050_INTERRUPT_FIFO_OFLOW_BIT)) || fifoCount >= 1024) {
//        // reset so we can continue cleanly
//        mpu.resetFIFO();
//      //  fifoCount = mpu.getFIFOCount();  // will be zero after reset no need to ask
//        Serial.println(F("FIFO overflow!"));
//
//    // otherwise, check for DMP data ready interrupt (this should happen frequently)
//    } else if (mpuIntStatus & _BV(MPU6050_INTERRUPT_DMP_INT_BIT)) {
//
//        // read a packet from FIFO
//  while(fifoCount >= packetSize){ // Lets catch up to NOW, someone is using the dreaded delay()!
//    mpu.getFIFOBytes(fifoBuffer, packetSize);
//    // track FIFO count here in case there is > 1 packet available
//    // (this lets us immediately read more without waiting for an interrupt)
//    fifoCount -= packetSize;
//  }
//        #ifdef OUTPUT_READABLE_QUATERNION
//            // display quaternion values in easy matrix form: w x y z
//            mpu.dmpGetQuaternion(&q, fifoBuffer);
//            Serial.print("quat\t");
//            Serial.print(q.w);
//            Serial.print("\t");
//            Serial.print(q.x);
//            Serial.print("\t");
//            Serial.print(q.y);
//            Serial.print("\t");
//            Serial.println(q.z);
//        #endif
//
//        #ifdef OUTPUT_READABLE_EULER
//            // display Euler angles in degrees
//            mpu.dmpGetQuaternion(&q, fifoBuffer);
//            mpu.dmpGetEuler(euler, &q);
//            Serial.print("euler\t");
//            Serial.print(euler[0] * 180/M_PI);
//            Serial.print("\t");
//            Serial.print(euler[1] * 180/M_PI);
//            Serial.print("\t");
//            Serial.println(euler[2] * 180/M_PI);
//        #endif
//
//        #ifdef OUTPUT_READABLE_YAWPITCHROLL
//            // display Euler angles in degrees
//            mpu.dmpGetQuaternion(&q, fifoBuffer);
//            mpu.dmpGetGravity(&gravity, &q);
//            mpu.dmpGetYawPitchRoll(ypr, &q, &gravity);
//            Serial.print("ypr\t");
//            Serial.print(ypr[0] * 180/M_PI);
//            Serial.print("\t");
//            Serial.print(ypr[1] * 180/M_PI);
//            Serial.print("\t");
//            Serial.println(ypr[2] * 180/M_PI);
//        #endif
//
//        #ifdef OUTPUT_READABLE_REALACCEL
//            // display real acceleration, adjusted to remove gravity
//            mpu.dmpGetQuaternion(&q, fifoBuffer);
//            mpu.dmpGetAccel(&aa, fifoBuffer);
//            mpu.dmpGetGravity(&gravity, &q);
//            mpu.dmpGetLinearAccel(&aaReal, &aa, &gravity);
//            Serial.print("areal\t");
//            Serial.print(aaReal.x);
//            Serial.print("\t");
//            Serial.print(aaReal.y);
//            Serial.print("\t");
//            Serial.println(aaReal.z);
//        #endif
//
//        #ifdef OUTPUT_READABLE_WORLDACCEL
//            // display initial world-frame acceleration, adjusted to remove gravity
//            // and rotated based on known orientation from quaternion
//            mpu.dmpGetQuaternion(&q, fifoBuffer);
//            mpu.dmpGetAccel(&aa, fifoBuffer);
//            mpu.dmpGetGravity(&gravity, &q);
//            mpu.dmpGetLinearAccel(&aaReal, &aa, &gravity);
//            mpu.dmpGetLinearAccelInWorld(&aaWorld, &aaReal, &q);
//            Serial.print("aworld\t");
//            Serial.print(aaWorld.x);
//            Serial.print("\t");
//            Serial.print(aaWorld.y);
//            Serial.print("\t");
//            Serial.println(aaWorld.z);
//        #endif
//    
//        #ifdef OUTPUT_TEAPOT
//            // display quaternion values in InvenSense Teapot demo format:
//            teapotPacket[2] = fifoBuffer[0];
//            teapotPacket[3] = fifoBuffer[1];
//            teapotPacket[4] = fifoBuffer[4];
//            teapotPacket[5] = fifoBuffer[5];
//            teapotPacket[6] = fifoBuffer[8];
//            teapotPacket[7] = fifoBuffer[9];
//            teapotPacket[8] = fifoBuffer[12];
//            teapotPacket[9] = fifoBuffer[13];
//            Serial.write(teapotPacket, 14);
//            teapotPacket[11]++; // packetCount, loops at 0xFF on purpose
//        #endif
//
//        // blink LED to indicate activity
//        blinkState = !blinkState;
//        digitalWrite(LED_PIN, blinkState);
//    }
// END MPU 

// Leg dimension

stretch = analogRead(pinVol);
//Serial.println(stretch);
// New value calculation
for (int i = 1; i < mean; i++)
  {
    average = average + alpha * data_filtered[n - i];
  }
  data_filtered[n] = (alpha * stretch) + average;
  average = 0;
  // data_filtered values update
  for (int i = 0; i < mean - 1; i++)
  {
    data_filtered[i] = data_filtered[i + 1];
  }

// Print Data
//stretch = data_filtered[n];
data_filtered[n] = data_filtered[n];
somma=somma+data_filtered[n];
conta=conta+1;
media=somma/conta;
//Serial.println(data_filtered[n]);
   if (millis() - Stime > 10000) {
    
    Stime = millis();
    currMax=1.1*RESthresh;
    if (media>currMax)
    {
    swelling=1;
    }
    else
    {
    swelling=0;
    }
    RESthresh=media;
    somma=0;
    conta=0;
    media=0;
  }
 

//// END Leg dimension

// Foot presssure

fs1 = analogRead(pressa);
fs2 = analogRead(pressp);
delay(50);
if (millis() < 1000)
{
    fs1tot = fs1tot + fs1;
    fs2tot = fs2tot + fs2;
    cont++;
}
else {
fs1 = fs1 - fs1tot / cont;
//fs2 = fs2 - fs2tot / cont;
int f1 = map(fs1, 0, 1000, 0, 255);
int f2 = map(fs2, 0, 1000, 0, 255);
//  Serial.print("FSR 1 =  ");
//  Serial.println(fs1);
//  Serial.print("   FSR 2 =  ");
//  Serial.println(fs2);
delay(50);
fs1new = map(f1, 0, 255, 0, 1023);
fs2new = map(f2, 0, 255, 0, 1023);

if (fs2new > thresh_high)
{
 if (stepping == true)
          {
            count++;
            stepping = false;
          }
        }
        else if ( fs2 < thresh_low)
        {
          stepping = true;
        }
Acttime=millis();
distance = (count*steplength)/1000;
walkspeed = ((distance*1000000)/ Acttime)*3.6;
    //delay(100);
    if(fs1new >= 1040){
      digitalWrite(3,HIGH);
      contabad++;
    }
    else{
      digitalWrite(3, LOW);
    }
    if(fs2new >= 150){
      digitalWrite(4,HIGH);
      contabad++;
    }
    else{
      digitalWrite(4, LOW);
    }
}
BE=(contabad/4)/count;
if ((swelling=1 && celsius>32) && millis()>30000)
{
  DVT=1;
}
else
{
  DVT=0;
}

if (Oldfalling==1 || DVT==1)
{
digitalWrite(4,HIGH);
digitalWrite(3,HIGH);
}
BE=(contabad/2)/count;



////END Foot pressure
//  
  Serial.print(HR);
  Serial.write(',');
  Serial.print(fahrenheit);
  Serial.write(',');
  Serial.print(count);
  Serial.write(',');
  Serial.print(distance);
  Serial.write(',');
  Serial.print(walkspeed);
  Serial.write(',');
  Serial.print(DVT);
  Serial.write(',');
  Serial.print(BE);
  Serial.write(',');
  Serial.println(Oldfalling);







  

}
