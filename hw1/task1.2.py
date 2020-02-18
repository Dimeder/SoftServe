def summa():
# This is a function that sums and multiplies all the numbers in a list of
    list = [2, 3, 3, 4, 10]
    print("Result of sum: " + str(sum(list)))
    result = 1
    for x in list:
        result = result*x
    print("Result of multiply: " + str(result))
summa()
