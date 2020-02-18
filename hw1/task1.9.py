#This is a function, which validate string with brackets.
def brackets(str):
    if len(str) % 2 != 0:
        return "Not balanced"
    x = 0
    for i in str:
        if i == '[' and x >= 0:
            x += 1
        elif x >= 0:
            x -= 1
        else:
            return "Not balanced"
    if x == 0:
        return "Balanced"
    return "Not balanced"
str = "[][][]"

print(brackets(str))

brackets(str)
