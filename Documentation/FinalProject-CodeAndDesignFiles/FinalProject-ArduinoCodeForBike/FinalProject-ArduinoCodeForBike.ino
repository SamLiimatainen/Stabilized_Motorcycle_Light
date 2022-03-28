#include<Servo.h>
Servo Myservo;
Servo Myservo2;
float pos = 0;   
const int ServoPin = A3;
const int ServoPin2 = A2;

//----------------------------------------------------------------------------
#include <IRremote.h>
int RECV_PIN = 11; // define input pin on Arduino 
IRrecv irrecv(RECV_PIN); 
decode_results results; // decode_results class is defined in IRremote.h
//-----------------------------------------------------------------------------
const int Left = 16716015;
const int Right = 16734885;
const int Up =16718055;
const int Function1 = 16753245;
const int Function2 = 16736925;
const int Function3 = 16769565;
const int Seven     = 16769055;
const int Nine      = 16748655;


const int CenterAngle = 90;
const int MaxAngleLeft = 115;
const int MaxAngleRight = 65;
int ServoSpeedDelay = 35;


void setup()
{
  Serial.begin(9600); 
  Myservo.attach(ServoPin);
  Myservo2.attach(ServoPin2);
  Myservo.write(CenterAngle);
  Myservo2.write(CenterAngle);
  pos = CenterAngle;
  irrecv.enableIRIn(); // Start the receiver 
}

void loop()
{
  //IR Remote
  if (irrecv.decode(&results)) {
    //Serial.println(results.value,HEX); 
    Serial.println(results.value); 

    if(results.value == Left)
    {//Left
      Serial.println("Left"); 
      irrecv.resume(); // Receive the next value
      MoveServoLeft();
    }
    else if(results.value == Right)
    {//right
      Serial.println("Right");
      irrecv.resume(); // Receive the next value 
      MoveServoRight();
    }
    else if(results.value == Up)
    {
      Serial.println("Zero Position"); 
      irrecv.resume(); // Receive the next value
      MoveServoCenter();
    }
    else if(results.value == Function1)
    {
      irrecv.resume(); // Receive the next value
      MoveSideToSideFast();
    }
    else if(results.value == Function2)
    {
      irrecv.resume(); // Receive the next value
      LongSlowTurnLeft();
    }
    else if(results.value == Function3)
    {
      irrecv.resume(); // Receive the next value
      LongSlowTurnRight();
    }
    else if(results.value == Seven)
    {
      irrecv.resume(); // Receive the next value
      MoveToDeg(10);
    }
    else if(results.value == Nine)
    {
      irrecv.resume(); // Receive the next value
      MoveToDeg(-10);
    }
    else
    {
      irrecv.resume(); // Receive the next value 
    }
    
  }
  
}



void MoveServoLeft()
{
  for(pos;pos<=MaxAngleLeft;pos++)
  {
    Myservo.write(pos);
    Myservo2.write(pos);
    delay(ServoSpeedDelay);
  }
}

void MoveServoRight()
{
  for(pos;pos>=MaxAngleRight;pos--)
  {
    Myservo.write(pos);
    Myservo2.write(pos);
    delay(ServoSpeedDelay);
  }
}

void MoveServoCenter()
{
        if(pos > CenterAngle)
        {
          for(pos;pos>=CenterAngle;pos--)
          {
             Myservo.write(pos);
             Myservo2.write(pos);
             delay(ServoSpeedDelay);
          }
        }
        else
        {
          for(pos;pos<=CenterAngle;pos++)
          {
              Myservo.write(pos);
              Myservo2.write(pos);
              delay(ServoSpeedDelay);
          }
        }
}


void MoveSideToSideFast()
{
  ServoSpeedDelay = 35;
  for(int i=0;i<=5;i++)
  {
    if((i % 2)==0)
    {
      MoveServoRight();
    }
    else
    {
      MoveServoLeft();
    }
  }
  MoveServoCenter();
  ServoSpeedDelay = 35;
}

void LongSlowTurnLeft()
{
  ServoSpeedDelay = 35;
  MoveServoLeft();
  MoveServoCenter();
  ServoSpeedDelay = 35;
}


void LongSlowTurnRight()
{
  ServoSpeedDelay = 35;
  MoveServoRight();
  MoveServoCenter();
  ServoSpeedDelay = 35;
}

void MoveToDeg(int deg)
{
  int i = 0;
  if(deg>0 && pos < 120)
  {
      for(i=pos;i<=(pos+deg);i++)
      {
        Myservo.write(i);
        Myservo2.write(i);
        delay(ServoSpeedDelay);
      }
      pos = pos+deg;
  }
  else if(pos > 60)
  {
      for(i=pos;i>=(pos+deg);i--)
      {
         Myservo.write(i);
         Myservo2.write(i);
         delay(ServoSpeedDelay);
      }
      pos = pos+deg;
  }
  deg = 0;
}
