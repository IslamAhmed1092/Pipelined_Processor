vsim work.processor
add wave -position end  sim:/processor/clk
add wave -position end  sim:/processor/reset
add wave -position end  sim:/processor/in_port

add wave -position end  sim:/processor/fs/instruction
add wave -position end  sim:/processor/fs/pc_out
add wave -position end  sim:/processor/fs/isTwoWords

add wave -position end  sim:/processor/IFID_disable
add wave -position end  sim:/processor/ds/src
add wave -position end  sim:/processor/ds/dst
add wave -position end  sim:/processor/ds/ALU_operation
add wave -position end  sim:/processor/ds/imm
add wave -position end  sim:/processor/ds/writeBackNow
add wave -position end  sim:/processor/ds/writeReg
add wave -position end  sim:/processor/ds/writeData

add wave -position end  sim:/processor/es/ALU_Operation
add wave -position end  sim:/processor/es/A
add wave -position end  sim:/processor/es/B
add wave -position end sim:/processor/es/Immediate_in
add wave -position end  sim:/processor/es/ALU_Result
add wave -position end  sim:/processor/es/CCR_OUT

add wave -position end  sim:/processor/FORWARDING_WBdstA
add wave -position end  sim:/processor/FORWARDING_MEMdstA
add wave -position end  sim:/processor/FORWARDING_WBdstB
add wave -position end  sim:/processor/FORWARDING_MEMdstB

add wave -position end  sim:/processor/ms/ALU_Result

add wave -position end  sim:/processor/wb/WB_data

add wave -position end  sim:/processor/ds/regFile/reg0_data
add wave -position end  sim:/processor/ds/regFile/reg1_data
add wave -position end  sim:/processor/ds/regFile/reg2_data
add wave -position end  sim:/processor/ds/regFile/reg3_data
add wave -position end  sim:/processor/ds/regFile/reg4_data
add wave -position end  sim:/processor/ds/regFile/reg5_data
add wave -position end  sim:/processor/ds/regFile/reg6_data
add wave -position end  sim:/processor/ds/regFile/reg7_data




mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /processor/fs/im/ram(0)
mem load -filltype value -filldata 0000000000010000 -fillradix symbolic /processor/fs/im/ram(1)
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /processor/fs/im/ram(2)
mem load -filltype value -filldata 0000000100000000 -fillradix symbolic /processor/fs/im/ram(3)


mem load -filltype value -filldata 0000001000000000 -fillradix symbolic /processor/fs/im/ram(16)
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /processor/fs/im/ram(17)
mem load -filltype value -filldata 0000010000000000 -fillradix symbolic /processor/fs/im/ram(18)
mem load -filltype value -filldata 0100001000001000 -fillradix symbolic /processor/fs/im/ram(19)
mem load -filltype value -filldata 0100010000001000 -fillradix symbolic /processor/fs/im/ram(20)
mem load -filltype value -filldata 0100110000001000 -fillradix symbolic /processor/fs/im/ram(21)
mem load -filltype value -filldata 0100110000010000 -fillradix symbolic /processor/fs/im/ram(22)
mem load -filltype value -filldata 0100001000010000 -fillradix symbolic /processor/fs/im/ram(23)
mem load -filltype value -filldata 0100010000001000 -fillradix symbolic /processor/fs/im/ram(24)
mem load -filltype value -filldata 0100011000010000 -fillradix symbolic /processor/fs/im/ram(25)
mem load -filltype value -filldata 0100101000001000 -fillradix symbolic /processor/fs/im/ram(26)
mem load -filltype value -filldata 0100101000010000 -fillradix symbolic /processor/fs/im/ram(27)
mem load -filltype value -filldata 0000001000000000 -fillradix symbolic /processor/fs/im/ram(28)
mem load -filltype value -filldata 0100111000001000 -fillradix symbolic /processor/fs/im/ram(29)
mem load -filltype value -filldata 0101000000010000 -fillradix symbolic /processor/fs/im/ram(30)
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /processor/fs/im/ram(31)


force -freeze sim:/processor/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/processor/reset 1 0
run
force -freeze sim:/processor/reset 0 0
force -freeze sim:/processor/in_port 16#5 0
run 600
force -freeze sim:/processor/in_port 16#10 0
run


