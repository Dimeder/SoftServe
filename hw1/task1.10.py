def charFreq(str):
    ''' This is a function that takes a string and builds
    a frequency listing of the characters contained in it. '''
    dictionary = {}
    for i in range(len(str)):
        if (str[i] in dictionary):
            dictionary[str[i]] += 1
        else:
            dictionary[str[i]] = 1
    print(dictionary)

str = "abbabcbdbabdbdbabaababcbcbab"
charFreq(str)
