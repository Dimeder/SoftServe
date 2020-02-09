def isPalindrome():
#This is a function isPalindrome() that recognizes palindromes (i.e. words that look the same written backwards).
    word = input("Please enter a word for check it on: ")
    if word == word[::-1]:
        print("This word is palindrome")
    else:
        print("Try another word")
        return isPalindrome()
isPalindrome()
