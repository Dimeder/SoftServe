from time import sleep
import random

def histogram():
#This is a procedure histogram() that takes a list of random integers and prints a histogram to the screen.
    list = random.sample(range(1, 20), 10)
    for x in list:
        print("*"*x)
        sleep(0.6)
histogram()
