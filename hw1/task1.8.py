from random import randrange

def game():
#This is a function number-guessing game, that takes 2 int parameters defining the range.
    m = int(input("Please, enter number from 1 till 3:"))
    n = randrange(3)
    if m == n:
        print("You Win!")
    else:
        print("Try again!")
        return game()
game()
