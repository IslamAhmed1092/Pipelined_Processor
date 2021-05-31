import json
import sys
#read the opcodes from the json file
with open("opcodes.json", "r") as read_file:
    opcodeJson = json.load(read_file)
#dictonary for variables and labels addresses
variabls = {}
variablsIntiailzations = {}
labels ={}
#helper functions
def mybin(x,numberOfbits =10):
    out = [0]*numberOfbits
    idx = numberOfbits-1
    if x < 0:
      out[0]=1
    x = abs(x)
    while x and idx >0:
      out[idx] = x %2 
      x>>=1
      idx-=1
    strout = ""
    for ele in out:  
	    strout += str(ele) 
    return strout
def getVariable(var):
    if var not in variabls :
        print("variable"+var+" is not defined at  ")
        quit(-1)
    return mybin(variabls[var]-currentInstruction-2,16)
def oprandWords(oprand):
    if oprand[0]== 'R' or oprand[0]== '-' or oprand[0]== '(':
        return 0
    elif oprand[0]=='@' and (oprand[1]=='(' or oprand[1]=='-' or oprand[1]=='R') :
        return 0
    elif oprand[0]=='@' and (oprand[1]=='#' or  oprand[1]!='R'):
        return 1
    ##number  or var   
    elif oprand[0]=='#' or oprand[0]!= 'R':
        return 1

def encodeOperand(oprand):
    #Rn
    if oprand[0]== 'R':
        return (opcodeJson["DIR-REG"]+opcodeJson[oprand[0:2]],"")
    #-(Rn)
    elif oprand[0]== '-':
        return (opcodeJson["DIR-AUTODEC"]+opcodeJson[oprand[2:4]],"")
    #(Rn)+
    elif oprand[0]== '(':
        return (opcodeJson["DIR-AUTOINC"]+opcodeJson[oprand[1:3]],"")
    #@(Rn)+
    elif oprand[0]=='@' and oprand[1]=='R' :
        return (opcodeJson["IND-REG"]+opcodeJson[oprand[1:3]],"")
    
    elif oprand[0]=='@' and oprand[1]=='(' :
        return (opcodeJson["IND-AUTOINC"]+opcodeJson[oprand[2:4]],"")
    #@-(Rn)
    elif oprand[0]=='@' and oprand[1]=='-' :
        return (opcodeJson["IND-AUTODEC"]+opcodeJson[oprand[3:5]],"")
    #@#number
    elif oprand[0]=='@' and oprand[1]=='#' :
        return (opcodeJson["IND-AUTOINC"]+opcodeJson["R7"]+mybin(int(oprand[2:]),16))
    #@var
    elif oprand[0]=='@' and oprand[1]!='R' :
        return (opcodeJson["IND-INDEX"]+opcodeJson["R7"]+getVariable(oprand[1:]))
    ##number    
    elif oprand[0]=='#':
        return (opcodeJson["DIR-AUTOINC"]+opcodeJson["R7"],mybin(int(oprand[1:]),16))
    #var
    elif oprand[0]!= 'R':
        return (opcodeJson["DIR-INDEX"]+opcodeJson["R7"],getVariable(oprand))    

def bitstring_to_bytes(s):
    return int(s, 2).to_bytes((len(s) + 7) // 8, byteorder='big')


#read input file
file1 = open(sys.argv[1], 'r') 
Lines = file1.readlines() 

currentInstruction = 0
instructions = ""
currentLine = 0
intializationWords =0
#first pass 
for L in Lines:
    L=L.replace("\n","")
    L=L.replace("\t","")
    Words = L.split(" ")
    instruction=""
    if Words[0].upper() in opcodeJson:
        currentOp = opcodeJson[Words[0].upper()]
        
        if currentOp[1] == '2':
            #two oprand 
            if Words[1].split(",")[1]!="": 
                currentInstruction+=oprandWords(Words[1].split(",")[0].upper())+oprandWords(Words[1].split(",")[1].upper())
        
            else: 
                currentInstruction+=oprandWords(Words[1][:-1].upper())+oprandWords(Words[2].upper())

        elif currentOp[1] == '1':
            #one oprand
            currentInstruction+=oprandWords(Words[1])
        currentInstruction+=1    
    elif Words[0].lower() == "define":
        #variables
        if Words[1] in variabls:
            print("redeclartion of variable "+Words[1])
            quit(-1)
        variabls[Words[1]]=currentInstruction
        variablsIntiailzations[Words[1]]=Words[2]
        currentInstruction+=1
    elif Words[0] != ";" and Words[0] != "\n" and Words[0] != ""  and Words[0] != "\t" :
        #labels
        if Words[0][:-1] in labels:
            print(L)
            print("redeclartion of label "+Words[0][:-1])
            quit(-1)
        labels[Words[0][:-1]]= currentInstruction
        
#second pass 
currentInstruction=0
for L in Lines:
    L=L.replace("\n","")
    L=L.replace("\t","")
    Words = L.split(" ")
    instruction=""
    
    if Words[0].upper() in opcodeJson:
        currentOp = opcodeJson[Words[0].upper()]
        
        if currentOp[1] == '2':
            #two oprand 

            
            if Words[1].split(",")[1]!="": 
                source = encodeOperand(Words[1].split(",")[0].upper())
                destination = encodeOperand(Words[1].split(",")[1].upper())
            else: 
                source = encodeOperand(Words[1][:-1].upper())
                destination = encodeOperand(Words[2].upper())
            
            instruction+=currentOp[0]+source[0]+destination[0]+source[1]+destination[1]
            instructions+=instruction
            if Words[1].split(",")[1]!="": 
                currentInstruction+=oprandWords(Words[1].split(",")[0].upper())+oprandWords(Words[1].split(",")[1].upper())
        
            else : 
                currentInstruction+=oprandWords(Words[1][:-1].upper())+oprandWords(Words[2].upper())
        elif currentOp[1] == '1':
            #one oprand
            source = encodeOperand(Words[1].upper())
            instruction+="1110"+currentOp[0]+source[0]+source[1]+"11"
            instructions+=instruction
            currentInstruction+=oprandWords(Words[1].upper())
           
        elif currentOp[1] == '0':
            #branching
            #very long jump gives an error
            
            if currentInstruction - labels[Words[1]] > 2**9:
                print("cant preform this long jump at line "+currentLine)
                quit(-1)
            instruction += "110"+currentOp[0]+mybin(labels[Words[1]]-currentInstruction-1)
            instructions+=instruction

        elif currentOp[1] == '3':
            #no oprand
            instruction += "11110"+currentOp[0]+"0000000000"
            instructions+=instruction
            
        else:
            #jump sub routine
            instruction += "11111"+currentOp[0]+"000000000"
            instructions+= instruction
        currentInstruction+=1
    elif Words[0].lower() == "define":
        #variables
        variabls[Words[1]]=currentInstruction
        instruction =mybin(int(Words[2]),16)
        instructions +=instruction
        currentInstruction+=1

#write output
intructionsInBytes = bitstring_to_bytes(instructions)
with open(sys.argv[2], 'wb') as output:
    output.write(intructionsInBytes)
for i in range(0,len(instructions),16):
    print(instructions[i:i+16])
