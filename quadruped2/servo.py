import RPi.GPIO as GPIO
from time import sleep
GPIO.setmode(GPIO.BOARD)
GPIO.setup(07, GPIO.OUT)
GPIO.setup(13, GPIO.OUT)

GPIO.setup(03, GPIO.OUT)
GPIO.setup(5, GPIO.OUT)
pwm=GPIO.PWM(13, 50)
pwm2=GPIO.PWM(07, 50)
pwm.start(0)
pwm2.start(0)
pwm3=GPIO.PWM(3, 50)
pwm4=GPIO.PWM(05, 50)
pwm3.start(0)
pwm4.start(0)
i = 0
f1=open("anglesl.txt","r");
a=f1.read()
f2=open("anglesr.txt","r");
b=f2.read()
li1 = list(a.split("\n"))
li2 = list(b.split("\n"))
GPIO.output(13, True)
GPIO.output(7, True)
GPIO.output(3, True)
GPIO.output(5, True)
        
def SetAngle(anglel1,angler1,anglel2,angler2):
	dutyl1 = anglel1 / 18 + 2
	dutyr1 =  angler1/ 18 + 2
	dutyl2 = anglel2 / 18 + 2
	dutyr2 =  angler2/ 18 + 2
	pwm.ChangeDutyCycle(dutyl1)
        pwm2.ChangeDutyCycle(dutyr1)
	pwm3.ChangeDutyCycle(dutyl2)
        pwm4.ChangeDutyCycle(dutyr2)
	sleep(0.025)
	pwm.ChangeDutyCycle(0)
        pwm2.ChangeDutyCycle(0)
	pwm3.ChangeDutyCycle(0)
        pwm4.ChangeDutyCycle(0)
	
while i<10000:
   SetAngle(180.0 - float(li1[i+30]),180.0 - float(li2[i+300]),float(li1[i]),float(li2[i]))
   #print(float(li[i]) float(li2[i]))
   sleep(0.0001)
   i=i+1

GPIO.output(13, False)
GPIO.output(7, False)
GPIO.output(3, False)
GPIO.output(5, False)
	
pwm.stop()
pwm2.stop()
pwm3.stop()
pwm4.stop()

GPIO.cleanup()
