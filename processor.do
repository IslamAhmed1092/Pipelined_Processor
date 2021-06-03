restart -f



mem load -i assembler/Memory.mem /processor/fs/im/ram


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
