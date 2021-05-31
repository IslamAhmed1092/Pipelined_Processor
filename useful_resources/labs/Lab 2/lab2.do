
########################################33
## Open Simulation
# vsim libraryName.EntityName(ArchitectureName)
# architecture Name is optional
#example
##############  vsim  work.mux_generic
#or
##############  vsim  work.mux_generic(with_select_mux)
#to open simulation and change generic value use the option -g<VariableName>=<Value>
#example set generic n with 8
vsim  work.mux_generic(with_select_mux) -gn=8
#add all in/out and signals in wave
#add wave sim:/EntityName/signalOrPortName
#add wave sim:/EntityName/*                #use * for all of in/outs
#if the entity uses another component
#add wave sim:/EntityName/ComponentLabel/signalOrPortName
#example
add wave sim:/mux_generic/*
#to force a value in the simulation with your own Format
#force sim:/entityName/signalOrPortName   length'format<Value>
#example to force in0 which is 8 bits with hexadecimal
force sim:/mux_generic/in0 8'h0F
#you can omit the "sim:/mux_generic" if it is in the toplevel entity 
force in1 8'hFF
#to use binary format
force in2 8'b01110000
#to use decimal format
force in3 8'd33
#to set a clock
# force signal/port <value>  <at time>,<another value>  <at time> -repeat <cycletime>
# for example set sel(0) with 0 at time 0 , then with 1 at time 50 , repeate each 100 ps #this start with a falling edge
force sel(0) 0 0,1 {50 ps} -r 100
force sel(1) 0 0,1 {100 ps} -r 200
run
run
run 200
#to set the radix to a certain signal/port
property wave -radix hex in0
#or to set it to all signals
property wave -radix hex *
#to quit simulation
#quit -sim
#a good tutorial website could be found here http://www.tkt.cs.tut.fi/tools/public/tutorials/mentor/modelsim/getting_started/gsms.html

