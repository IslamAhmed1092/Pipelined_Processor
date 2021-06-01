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


def process_nooperand(instruction):
    return "000" + instructions[instruction]['code'] + '0'*9


def process_oneoperand(instruction):
    code = "010"
    inst, reg = instruction.split(" ")
    code += instructions[inst]['code']
    code += "000"  # To be determined
    code += registers[reg]
    code += "000"
    return code


def encode_decimal(operand):
    code = ''
    operand = int(operand)
    if operand < 0:
        code = bin(operand % (1 << 16))[2:]
    else:
        code = '0'*(16-len(bin(operand)[2:])) + bin(operand)[2:]

    return code


def process_twooperand(instruction):
    code = "100"
    inst, regs = instruction.split(" ")
    reg1, reg2 = regs.split(",")
    opcode = instructions[inst]["code"]
    code += opcode

    if opcode <= "0100":
        code += registers[reg1] + registers[reg2]
        code += "000"
        return code, ""
    else:
        reg2 = encode_decimal(reg2)
        if opcode == "0101":
            code += "000" + registers[reg1] + reg2
        else:
            code += registers[reg1] + "000" + reg2
        code += "000"

        return code[:16], code[16:]


def process_memory(instruction):
    code = "001"
    inst, regs = instruction.split(" ")
    opcode = instructions[inst]["code"]
    code += opcode

    if opcode == "0000" or opcode == "0001":
        code += "000" + registers[regs] + "000"
        return code, ""

    reg1, reg2 = regs.split(",")

    if opcode == "0010":
        code += "000" + registers[reg1] + encode_decimal(reg2) + "000"

    if opcode == "0011" or opcode == "0100":
        code += registers[reg2.split("(")[1][:-1]] + \
            registers[reg1] + encode_decimal(reg2.split("(")[0]) + "000"

    return code[:16], code[16:]


# print(process_memory("STD R2,200(R5)"))

testcase_filename = "Memory.asm"
if(len(sys.argv) >= 2):
    testcase_filename = sys.argv[1]

testcase = open(testcase_filename)
lines = cleanup(testcase)

# print(len(lines))
# print(lines)
