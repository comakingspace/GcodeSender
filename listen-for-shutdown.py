# listen to a power-button on Pin 5 (SCL)
# based on:
# https://howchoo.com/g/mwnlytk3zmm/how-to-add-a-power-button-to-your-raspberry-pi
import RPi.GPIO as GPIO
import subprocess
GPIO.setmode(GPIO.BCM)
GPIO.setup(3, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.wait_for_edge(3, GPIO.FALLING)
print('Power Down')
subprocess.call(['shutdown', '-h', 'now'], shell=False)