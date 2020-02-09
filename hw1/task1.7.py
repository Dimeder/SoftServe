a = [[1, 2, 3],[4, 5, 6],[7, 8, 9]]
b = [0,0,0],[0,0,0],[0,0,0]

def diagonalReverse(matrix):
#This is a function diagonalReverse() that takes matrix 3x3 and returns diagonal-reversed.
    for i in range(len(a)):
        for j in range(len(a[0])):
            b[j][i] = a[i][j]
    for row in b:
        print(row)

diagonalReverse(a)
