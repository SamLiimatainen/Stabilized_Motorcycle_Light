# :monocle_face: Dallas Dominguez :monocle_face:
#### PID: A16050696
# :stuck_out_tongue_closed_eyes: Samuel Liimatainen :stuck_out_tongue_closed_eyes:
#### PID: A16591201
# :sunglasses: Zhe Mo :sunglasses:
#### PID: A15538969

#### ECE16 - WI22


## Lab 5: Initial Prototype

### Challenge 1  
Link to the slides:  
https://docs.google.com/presentation/d/1i5ICdTrG9TdJGY23H8ERxXfeR0voz1tDyQDupnCF9DE/edit?pli=1#slide=id.g112cad0e7ec_0_0  

Textual Description:  
Our customer's need is a better illumination when cornering at night. According to the customer's description, he has been bothered by this issue since buying the bike. When he makes a turn at night, because the head light is inclined, the road ahead of the corner is not illuminated. Therefore, the lack of illumination poses a danger to the driver (the customer). In addition, the customer's mother takes customer's safety very seriously, and althougis the customer currently remedying this issue by using his high beams to quickly capture a view of the turn before making it, the customer seeks a better solution.  

According to the survey response, although 5 people admit that they ride motorcycles at night, 7 people report that they sometimes cannot claerly see the road due to the insufficient illumination. This indicates that not only motorcycles, other vehcles also have this issue. And the surveyees are willing to find a solution even though there is a side effect (high price). This gives us a chance to do cool (high technology) things. We show a clip of driving motorcycle at night, and surveyees admit that they cannot see the road clearly when cornering. And they consider the driver not only poses a danger to himself but also other drivers. We then explore people's attitude towards the high-power LED light technology, and half of the surveyees don't have a negative bias towards this technology. Thus, we consider to use this technology.  

We have searched through many techonology, and find three power methods. They are BMW Adaptive Cornering Light System, Yamaha LED Cornering light system, and ALLight Adaptive Level light. The first two methods is kind of "high-technology", so we aim at the solution that is probable to be achieved using our current materials and knowledge: the third method. We want to design a self-stablizing platform so that the light can always stay level. In order to achieve this, we need gyroscope and accelerometer, and also 3D print some components. Finally, using this product, however the motorcycle is cornering, the full width of the beam remains spread across the road.  

ICA 8:
<img width="1066" alt="Slide1" src="https://user-images.githubusercontent.com/55855534/155386772-0cf88f65-5441-45b8-af3d-1e38791e6431.png">  
<img width="1066" alt="Slide2" src="https://user-images.githubusercontent.com/55855534/155386800-09ed371d-e588-4cc5-91ec-4003e3ed76aa.png">  
<img width="1061" alt="Slide3" src="https://user-images.githubusercontent.com/55855534/155386871-c801f794-73ef-4f1c-b19c-0ca61c761f7c.png">  
  

### Challenge 2  
**Customer interview/feedback**:  
We reviewed our design plan with our client Teo, and he agreed that a single axis stabilized light will satisfy his needs. He pointed out that the motor form factor needs to fit inside his OEM light on his motorcycle, but upon further discussion we agreed that for the context of this class we will ignore the size requirements of fitting in the OEM light. Our meeting with Teo has shown us that our current design should be on track for satisfying his needs, but maybe add in plans for the future on what the physical form could look like given more time.  
    
#### TIMELINE:  
\___Functioning Demo___  
\___Poster___  
\___Presentation___  

**ToDo**:  
- Meet up and test to see what kind of motor/controller to use  
- What kind of light are we going to use(laser horizon?)  
- We need to decide what our hardware/structure will be  
- Code and integration? (Possibly Dallas code from last quarter)  
- Design the hard structure  
- Make sure we have hardware i.e. pcn etc.  
- 3D print and Laser cut stuff  
- Assemble the structure  
- Put all the electronics together  
- Test  
  
**Week 7**:  
- Meet up and test to see what kind of motor/controller to use  
- What kind of light are we going to use(laser horizon?)  
- We need to decide what our hardware/structure will be  
- Code and integration? (Possibly Dallas code form last quarter)  
  
**Week 8**:  
- ~~Design the hard structure~~  
- ~~Make sure we have hardware i.e. pcb etc.~~  
- ~~3D print and Laser cut stuff~~  
- ~~Assemble the structure~~  
- ~~Put all the electronics together~~  
- Start to design the poster  
- Work on presentation slides  
  
**Week 9**:  
- Test  
- Final Poster Design Done  
- Final Presentation Done  
  
**Week 10**:  
- Big Day  
- Extra time if we run late on anything(poster,presentation, etc)  
  
**Final Week**: Present Our Final Project  
  
**TEAM MEMBER RESPONSIBILITIES**:  
Sam Liimatainen:  
- Hardware and software implementation  
- 3d CAD Design  
- Assembly  
  
Zhe Mo:  
- Hardware and software implementation  
- Assembly  
  
Dallas Dominguez:  
- 3D Printing  
- Assembly  
  
  
**DELIVERABLES**:  
- Stabilized platform  
- light to create a spread out beam  
- working stabilized light product  
  

### Challenge 3  
How does this initial prototype work?<br> 
This initial prototype takes data from the MPU6050 and maps this data from 90 to -90 degrees. This is then written to the servo unit. This will allow the MPU6050 to be mounted to the frame of the motorcycle, and the light will be attached to the servo. 

 What does it show?<br> 
This shows that the light can be mounted to the servo arm and the beam width will be stable across the horizon.

How did you implement it?<br> 
This initial prototype is completed using code from this tutorial and Arduino pro mini. <br> 
- https://howtomechatronics.com/tutorials/arduino/arduino-and-mpu6050-accelerometer-and-gyroscope-tutorial/<br> 


Short demo video recording:<br> 
Shows the MPU6050 sensor controls the servo based on its Y-axis rotation. <br> 

![](IMB_8uG5rq.gif)
