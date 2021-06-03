restart -f



mem load -i assembler/Memory.mem /processor/fs/im/ram

mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /processor/fs/im/ram(0)
mem load -filltype value -filldata 0000000000010000 -fillradix symbolic /processor/fs/im/ram(1)
mem load -filltype value -filldata 0000001000000000 -fillradix symbolic /processor/fs/im/ram(16)
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /processor/fs/im/ram(17)
mem load -filltype value -filldata 0000010000000000 -fillradix symbolic /processor/fs/im/ram(18)
mem load -filltype value -filldata 0100001000001000 -fillradix symbolic /processor/fs/im/ram(19)
mem load -filltype value -filldata 0100010000001000 -fillradix symbolic /processor/fs/im/ram(20)
mem load -filltype value -filldata 0100110000001000 -fillradix symbolic /processor/fs/im/ram(21)
mem load -filltype value -filldata 0100110000010000 -fillradix symbolic /processor/fs/im/ram(22)
mem load -filltype value -filldata 0100001000010000 -fillradix symbolic /processor/fs/im/ram(23)
mem load -filltype value -filldata 0100101000001000 -fillradix symbolic /processor/fs/im/ram(24)
mem load -filltype value -filldata 0100101000010000 -fillradix symbolic /processor/fs/im/ram(25)
mem load -filltype value -filldata 0000001000000000 -fillradix symbolic /processor/fs/im/ram(26)
mem load -filltype value -filldata 0100111000001000 -fillradix symbolic /processor/fs/im/ram(27)
mem load -filltype value -filldata 0101000000010000 -fillradix symbolic /processor/fs/im/ram(28)
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /processor/fs/im/ram(29)
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /processor/fs/im/ram(30)
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /processor/fs/im/ram(31)
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /processor/fs/im/ram(1048575)
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /processor/fs/im/ram(1048574)

force -freeze sim:/processor/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/processor/reset 1 0
run
force -freeze sim:/processor/reset 0 0
force -freeze sim:/processor/in_port 16#5 0
run 600
force -freeze sim:/processor/in_port 16#10 0
run
force -freeze sim:/processor/in_port 16#FFFF 0
run
force -freeze sim:/processor/in_port 16#F320 0
run
