// I2C device class (I2Cdev) demonstration Processing sketch for MPU6050 DMP output
// 6/20/2012 by Jeff Rowberg <jeff@rowberg.net>
// Updates should (hopefully) always be available at https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_jrowberg_i2cdevlib&d=DwIGAg&c=-35OiAkTchMrZOngvJPOeA&r=twLTu8AVwSCnvoMpxIuQeVS1KgloxtNO5MGIgpcyZaM&m=9LBsY2U47rgiRgdvpbVSUjtuZwOPC0Fm7NHDzJy-_mmOvU6d9I0bzmAYzUu_CNa6&s=DWEnvgrsebnsAfgnCJBl2gF1YC08nHcIn0aXhhk19wo&e= 
//
// Changelog:
//     2012-06-20 - initial release

/* ============================================
I2Cdev device library code is placed under the MIT license
Copyright (c) 2012 Jeff Rowberg

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
===============================================
*/

import processing.serial.*;
import processing.opengl.*;
import toxi.geom.*;
import toxi.processing.*;

// NOTE: requires ToxicLibs to be installed in order to run properly.
// 1. Download from https://urldefense.proofpoint.com/v2/url?u=http-3A__toxiclibs.org_downloads&d=DwIGAg&c=-35OiAkTchMrZOngvJPOeA&r=twLTu8AVwSCnvoMpxIuQeVS1KgloxtNO5MGIgpcyZaM&m=9LBsY2U47rgiRgdvpbVSUjtuZwOPC0Fm7NHDzJy-_mmOvU6d9I0bzmAYzUu_CNa6&s=Q28Fv1g0yHqV_wftJN3o5ScDZHsdRb9DdUP4lWFpzIQ&e= 
// 2. Extract into [userdir]/Processing/libraries
//    (location may be different on Mac/Linux)
// 3. Run and bask in awesomeness

ToxiclibsSupport gfx;

Serial port;                         // The serial port
char[] teapotPacket = new char[14];  // InvenSense Teapot packet
int serialCount = 0;                 // current packet byte position
int synced = 0;
int interval = 0;

float[] q = new float[4];
Quaternion quat = new Quaternion(1, 0, 0, 0);

float[] gravity = new float[3];
float[] euler = new float[3];
float[] ypr = new float[3];

void setup() {
    // 300px square viewport using OpenGL rendering
    size(1200, 1200, OPENGL);
    gfx = new ToxiclibsSupport(this);

    // setup lights and antialiasing
    lights();
    smooth();
  
    // display serial port list for debugging/clarity
    println(Serial.list());

    println("Port 0", Serial.list()[0]);
    println("Port 1", Serial.list()[1]);
    println("Port 2", Serial.list()[2]);
    println("Port 3", Serial.list()[3]);
    println("Port 4", Serial.list()[4]);
    println("Port 5", Serial.list()[5]);
    println("Port 6", Serial.list()[6]);
    println("Port 7", Serial.list()[7]);
    println("Port 8", Serial.list()[8]);
    println("Port 9", Serial.list()[9]);
    println("Port 10", Serial.list()[10]);
    println("Port 11", Serial.list()[11]);
    println("Port 12", Serial.list()[12]);
    println("Port 13", Serial.list()[13]);
    println("Port 14", Serial.list()[14]);
    println("Port 15", Serial.list()[15]);
    println("Port 16", Serial.list()[16]);
    println("Port 17", Serial.list()[17]);
  
    // get the first available port (use EITHER this OR the specific port code below)
    String portName = Serial.list()[4];
    println("the port the code is using is", portName);
    // get a specific serial port (use EITHER this OR the first-available code above)
    //String portName = "COM4";
    
    // open the serial port
    port = new Serial(this, portName, 9600);
    
    // send single character to trigger DMP init/start
    // (expected by MPU6050_DMP6 example Arduino sketch)
    port.write('r');
}

void draw() {
    if (millis() - interval > 1000) {
        // resend single character to trigger DMP init/start
        // in case the MPU is halted/reset while applet is running
        port.write('r');
        interval = millis();
    }
    
    // translate everything to the middle of the viewport
    //pushMatrix();
    translate(width / 2, height / 2, 0);
    
    // black background
    background(0);
    
    //Display Roll, Pitch, and Yaw Angles in Degrees
    textSize(22);
    text("Roll: " + int(ypr[2]*180.0f/PI) + "     Pitch: " + int(ypr[1]*180.0f/PI) + "     Yaw: " + int(ypr[0]*180.0f/PI), -100, 265);
    

    // 3-step rotation from yaw/pitch/roll angles (gimbal lock!)
    // ...and other weirdness I haven't figured out yet
    rotateY(-ypr[0]);
    rotateZ(-ypr[1]);
    rotateX(-ypr[2]);

    // toxiclibs direct angle/axis rotation from quaternion (NO gimbal lock!)
    // (axis order [1, 3, 2] and inversion [-1, +1, +1] is a consequence of
    // different coordinate system orientation assumptions between Processing
    // and InvenSense DMP)
    //float[] axis = quat.toAxisAngle();
    //rotate(axis[0], -axis[1], axis[3], axis[2]);
    
    //FOR A REALLY COOL TEXT EFFECT
    //Display Roll, Pitch, and Yaw Angles in Degrees
    //textSize(22);
    //text("Roll: " + int(ypr[2]*180.0f/PI) + "     Pitch: " + int(ypr[1]*180.0f/PI) + "     Yaw: " + int(ypr[0]*180.0f/PI), -100, 265);
    
    
    // 3D 0bject
    textSize(30);  
    fill(0, 76, 153);
    box (386, 40, 75); // Draw box
    textSize(25);
    fill(255, 255, 255);
    text("Model", -183, 10, 101);
}

void serialEvent(Serial port) {
    interval = millis();
    while (port.available() > 0) {
        int ch = port.read();

        if (synced == 0 && ch != '$') return;   // initial synchronization - also used to resync/realign if needed
        synced = 1;
        print ((char)ch);

        if ((serialCount == 1 && ch != 2)
            || (serialCount == 12 && ch != '\r')
            || (serialCount == 13 && ch != '\n'))  {
            serialCount = 0;
            synced = 0;
            return;
        }

        if (serialCount > 0 || ch == '$') {
            teapotPacket[serialCount++] = (char)ch;
            if (serialCount == 14) {
                serialCount = 0; // restart packet byte position
                
                // get quaternion from data packet
                q[0] = ((teapotPacket[2] << 8) | teapotPacket[3]) / 16384.0f;
                q[1] = ((teapotPacket[4] << 8) | teapotPacket[5]) / 16384.0f;
                q[2] = ((teapotPacket[6] << 8) | teapotPacket[7]) / 16384.0f;
                q[3] = ((teapotPacket[8] << 8) | teapotPacket[9]) / 16384.0f;
                for (int i = 0; i < 4; i++) if (q[i] >= 2) q[i] = -4 + q[i];
                
                // set our toxilibs quaternion to new data
                quat.set(q[0], q[1], q[2], q[3]);

                
                // below calculations unnecessary for orientation only using toxilibs
                
                // calculate gravity vector
                gravity[0] = 2 * (q[1]*q[3] - q[0]*q[2]);
                gravity[1] = 2 * (q[0]*q[1] + q[2]*q[3]);
                gravity[2] = q[0]*q[0] - q[1]*q[1] - q[2]*q[2] + q[3]*q[3];
    
                // calculate Euler angles
                //euler[0] = atan2(2*q[1]*q[2] - 2*q[0]*q[3], 2*q[0]*q[0] + 2*q[1]*q[1] - 1);
                //euler[1] = -asin(2*q[1]*q[3] + 2*q[0]*q[2]);
                //euler[2] = atan2(2*q[2]*q[3] - 2*q[0]*q[1], 2*q[0]*q[0] + 2*q[3]*q[3] - 1);
    
                // calculate yaw/pitch/roll angles
                ypr[0] = atan2(2*q[1]*q[2] - 2*q[0]*q[3], 2*q[0]*q[0] + 2*q[1]*q[1] - 1);
                ypr[1] = atan(gravity[0] / sqrt(gravity[1]*gravity[1] + gravity[2]*gravity[2]));
                ypr[2] = atan(gravity[1] / sqrt(gravity[0]*gravity[0] + gravity[2]*gravity[2]));
    
                // output various components for debugging
                //println("q:\t" + round(q[0]*100.0f)/100.0f + "\t" + round(q[1]*100.0f)/100.0f + "\t" + round(q[2]*100.0f)/100.0f + "\t" + round(q[3]*100.0f)/100.0f);
                //println("euler:\t" + euler[0]*180.0f/PI + "\t" + euler[1]*180.0f/PI + "\t" + euler[2]*180.0f/PI);
                //println("ypr:\t" + ypr[0]*180.0f/PI + "\t" + ypr[1]*180.0f/PI + "\t" + ypr[2]*180.0f/PI);
                
            }
        }
    }
}
