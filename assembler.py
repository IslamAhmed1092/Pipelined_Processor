import sys

instructions = {
    "MOV": {'code': '0000', 'operands': '2'}, "ADD": {'code': '0001', 'operands': '2'}, "SUB": {'code': '0010', 'operands': '2'},
    "AND": {'code': '0011', 'operands': '2'}, "OR": {'code': '0100', 'operands': '2'}, "IADD": {'code': '0101', 'operands': '2'},
    "SHL": {'code': '0110', 'operands': '2'}, "SHR": {'code': '0111', 'operands': '2'},

    "CLR": {'code': '0000', 'operands': '1'}, "NOT": {'code': '0001', 'operands': '1'}, "INC": {'code': '0010', 'operands': '1'},
    "DEC": {'code': '0011', 'operands': '1'}, "NEG": {'code': '0100', 'operands': '1'}, "OUT": {'code': '0101', 'operands': '1'},
    "IN": {'code': '0110', 'operands': '1'}, "RLC": {'code': '0111', 'operands': '1'}, "RRC": {'code': '1000', 'operands': '1'},

    "NOP": {'code': '0000', 'operands': '0'}, "SETC": {'code': '0001', 'operands': '0'}, "CLRC": {'code': '0010', 'operands': '0'},

    "PUSH": {'code': '0000', 'operands': '1'}, "POP": {'code': '0001', 'operands': '1'}, "LDM": {'code': '0010', 'operands': '2'},
    "LDD": {'code': '0011', 'operands': '2'}, "STD": {'code': '0100', 'operands': '2'}
}

registers = {
    "R0": "000",
    "R1": "001",
    "R2": "010",
    "R3": "011",
    "R4": "100",
    "R5": "101",
    "R6": "110",
    "R7": "111"
}


def cleanup(testcase):
    lines = []
    org_location = False
    # Deletes all the comments, empty lines, and ORG instructions
    for line in testcase:
        if(line == "\n"):
            continue
        if(line[0] == "#"):
            continue
        if(line[0] == "."):
            org_location = True
            continue
        if(org_location):
            if(line.rstrip("\n").isnumeric()):
                continue
        lines.append(line.split("#")[0].rstrip().upper())

    return lines


testcase_filename = "OneOperand.asm"
testcase = open(testcase_filename)
lines = cleanup(testcase)

print(len(lines))
print(lines)
