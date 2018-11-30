#!/usr/bin/env python
import time
import numpy
import math
import RPi.GPIO as GPIO

class quadruped(object):

        import time
        import numpy
        import math
        import RPi.GPIO as GPIO

	def __init__(self):
		GPIO.setmode(GPIO.BOARD)
		GPIO.setup(07, GPIO.OUT)
        	self.GPIO.setup(13, GPIO.OUT)
        	self.pwm=GPIO.PWM(13, 50)
        	self.pwm2=GPIO.PWM(07, 50)
        	self.pwm.start(0)
        	self.pwm2.start(0)
        	GPIO.output(13, True)
        	GPIO.output(7, True)
        	        
        	self.coordinates = numpy.zeros((5,2))
        	self.angle=[0,0]
        	
       		self.l1=8.0
        	self.l2=6.0
        	self.l3=8.0
        	self.l4=0
        	self.l5=0
		
        	self.coordinates[0][0] = (self.l1)/2
        	self.coordinates[4][0] = -(self.l1)/2
        
		self.t1=0
		self.t2=0
		self.t3=0
		
		self.ox=0
		self.oy=-6
		self.r=3
		self.lh = 0
		self.delta = 0
		self.PI=math.pi
	
	def generateAngle(self):
		self.coordinates[2][0] = (self.r * math.cos(self.t3)) + self.ox
		self.coordinates[2][1] = (self.r * math.sin(self.t3)) + self.oy
		if(self.coordinates[2][1]<=self.oy):
			self.coordinates[2][1] = self.oy
		
		self.lh = math.sqrt(self.coordinates[2][0]**2 + self.coordinates[2][1]**2)
		self.delta = self.l2**2 + self.lh**2 - self.l3**2 - (self.l1**2)/4
		
		p = 4*(self.coordinates[2][1]**2 + self.coordinates[2][0]**2) + self.l1**2 + 4*self.coordinates[2][0]*self.l1
		q = -2*self.delta*self.l1 - 4*self.delta*self.coordinates[2][0] + 4*(self.coordinates[2][1]**2)*self.l1
		r = (self.coordinates[2][1]**2)*(self.l1**2 - 4*(self.l2**2)) + self.delta**2

	        if((-q - numpy.sqrt(numpy.abs(q**2 - (4*p*r))))/(2*p) > (-q + numpy.sqrt(numpy.abs(q**2 - (4*p*r))))/(2*p)):
        	    	self.coordinates[3][0] = (-q + numpy.sqrt(numpy.abs(q**2 - (4*p*r))))/(2*p)
        	else:
            		self.coordinates[3][0] = (-q - numpy.sqrt(numpy.abs(q**2 - (4*p*r))))/(2*p)
		self.coordinates[3][1] = (self.delta - self.coordinates[1][0]*(self.l1 + 2*self.coordinates[2][0]))/(2*self.coordinates[2][1])

		a = 4*(self.coordinates[2][1]**2 + self.coordinates[2][0]**2) + self.l1**2 - 4*self.coordinates[2][0]*self.l1
		b = 2*self.delta*self.l1 - 4*self.delta*self.coordinates[2][0] - 4*(self.coordinates[2][1]**2)*self.l1
		c = r

        	if((-b + numpy.sqrt(b**2 - (4*a*c)))/(2*a) > (-b - numpy.sqrt(b**2 - (4*a*c)))/(2*a)):
            		self.coordinates[1][0] = (-b + numpy.sqrt(b**2 - (4*a*c)))/(2*a)
        	else:
            		self.coordinates[1][0] = (-b - numpy.sqrt(b**2 - (4*a*c)))/(2*a)
		self.coordinates[1][1] = (self.delta + self.coordinates[3][0]*(self.l1 - 2*self.coordinates[2][0]))/(2*self.coordinates[2][1])

		self.t1 = math.atan(self.coordinates[1][1]/(self.coordinates[1][0] - self.coordinates[0][0]))
		self.t2 = math.atan(self.coordinates[3][1]/(self.coordinates[3][0] - self.coordinates[4][0]))
		
		self.angle=[numpy.abs(self.t1/self.PI*180) , numpy.abs(self.t2/self.PI*180)]
		#self.angle=[(self.t1/self.PI*180) , (self.t2/self.PI*180)]
		self.t3+=0.1
		#print self.coordinates[2][0], self.coordinates[2][1]
		#print self.angle

	def SetAngle(self,anglel,angler):
                print anglel,angler
       		dutyl = anglel / 18 + 2
        	dutyr =  angler/ 18 + 2
        	self.pwm.ChangeDutyCycle(dutyl)
        	self.pwm2.ChangeDutyCycle(dutyr)
        	time.sleep(0.02)
        	self.pwm.ChangeDutyCycle(0)
        	self.pwm2.ChangeDutyCycle(0)

    	def move(self):
        	i=0
        	while i<1000:
        	    quadruped_control.generateAngle()
        	    quadruped_control.SetAngle( 180.0 - self.angle[1], 180.0 - self.angle[0])
        	    i=i+1
        	GPIO.output(13, False)
        	GPIO.output(7, False)
        	self.pwm.stop()
        	self.pwm2.stop()
        	GPIO.cleanup()
	
		

if __name__=="__main__":
	quadruped_control=quadruped()
	quadruped_control.move()
