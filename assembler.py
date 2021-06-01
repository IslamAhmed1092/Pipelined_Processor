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

