def caesarCipher():
# This is a function caesarCipher that takes string and key(number), whuch returns encrypted string.
    alphabet = 'abcdefghijklmnopqrstuvwxyz'
    massege = input("Please, enter your massage for encrypt: ")
    n = int(input("Please enter key for encrypt: "))
    sec_massage = ""
    for x in massege.lower():
        position = alphabet.find(x)
        position += n
        sec_massage = sec_massage + alphabet[position]
    print("Your encrypted massage: " + sec_massage)
caesarCipher()
