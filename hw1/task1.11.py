def decToBin(num):
    bin = ""
    while num > 0:
        if num % 2 == 0:
            bin += "0"
        else:
            bin += "1"
        num //= 2
    return bin[::-1]
num = int(input("Enter a decimal integer: "))
print(decToBin(num))
decToBin(num)
