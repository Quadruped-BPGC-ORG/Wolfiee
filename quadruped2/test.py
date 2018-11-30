import RPi.GPIO as GPIO
from time import sleep
GPIO.setmode(GPIO.BOARD)
GPIO.setup(07, GPIO.OUT)
GPIO.setup(13, GPIO.OUT)
pwm=GPIO.PWM(13, 50)
pwm2=GPIO.PWM(07, 50)
GPIO.setup(03, GPIO.OUT)
GPIO.setup(5, GPIO.OUT)
pwm3=GPIO.PWM(3, 50)
pwm4=GPIO.PWM(5, 50)
pwm.start(0)
pwm2.start(0)
pwm3.start(0)
pwm4.start(0)
GPIO.output(13, True)
GPIO.output(7, True)
GPIO.output(3, True)
GPIO.output(5, True)
        
def SetAngle(angle):
	duty = angle / 18 + 2
	pwm.ChangeDutyCycle(duty)
        pwm2.ChangeDutyCycle(duty)
	pwm3.ChangeDutyCycle(duty)
        pwm4.ChangeDutyCycle(duty)
	sleep(0.1)
	pwm.ChangeDutyCycle(0)
        pwm2.ChangeDutyCycle(0)
	pwm3.ChangeDutyCycle(0)
        pwm4.ChangeDutyCycle(0)
i =0
while(i<5):
    SetAngle(90)
    sleep(0.01)
    i+=1
GPIO.output(13, False)
GPIO.output(7, False)
GPIO.output(3, False)
GPIO.output(5, False)
	
pwm.stop()
pwm2.stop()
pwm3.stop()
pwm4.stop()
