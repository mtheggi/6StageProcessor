
vsim work.simpleintegration
# vsim work.simpleintegration 
# Start time: 13:12:52 on Apr 17,2023
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.simpleintegration(archinteg)
# Loading work.fetch(archfetch)
# Loading work.pc(programcounter)
# Loading work.instruction_cache(sync_ram_a)
# Loading work.my_nadder(a_my_adder)
# Loading work.my_adder(a_my_adder)
# Loading work.mux2(arch1)
# Loading work.reg(archofreg)
# Loading work.decode(archofdecode)
# Loading work.controlunit(archofcontrolunit)
# Loading work.registersfile(archofregistersfile)
# Loading work.mux8(arch3)
# Loading work.mux4(arch2)
add wave -position end  sim:/simpleintegration/clk
add wave -position end  sim:/simpleintegration/rst
add wave -position end  sim:/simpleintegration/int
add wave -position end  sim:/simpleintegration/AluSelector
add wave -position end  sim:/simpleintegration/rs
add wave -position end  sim:/simpleintegration/rt
add wave -position end  sim:/simpleintegration/rd
add wave -position end  sim:/simpleintegration/rs_data
add wave -position end  sim:/simpleintegration/rt_data
add wave -position end  sim:/simpleintegration/FD_out
add wave -position end  sim:/simpleintegration/FD_in
add wave -position end  sim:/simpleintegration/DE_out
add wave -position end  sim:/simpleintegration/DE_in
add wave -position end  sim:/simpleintegration/instruction
add wave -position end  sim:/simpleintegration/immediateVal
add wave -position end  sim:/simpleintegration/updated_PC
add wave -position end  sim:/simpleintegration/OutputPort
add wave -position end  sim:/simpleintegration/ALURes
add wave -position end  sim:/simpleintegration/identifierBit
add wave -position end  sim:/simpleintegration/BranchFlag
add wave -position end  sim:/simpleintegration/ControllerSignal
add wave -position end  sim:/simpleintegration/ControllerSignalex
add wave -position end  sim:/simpleintegration/d/RF/out1
add wave -position end  sim:/simpleintegration/d/RF/out2
add wave -position end  sim:/simpleintegration/d/RF/out3
add wave -position end  sim:/simpleintegration/d/RF/out4
add wave -position end  sim:/simpleintegration/d/RF/out5
add wave -position end  sim:/simpleintegration/d/RF/out6
add wave -position end  sim:/simpleintegration/d/RF/out7
add wave -position end  sim:/simpleintegration/d/RF/out8
mem load -i {D:/CCE/Junior Year/Spring 23/CMPN301 - Computer Architecture/Project/6StageProcessor - new/6StageProcessor/testcases.mem} /simpleintegration/f/ic/ram
force -freeze sim:/simpleintegration/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/simpleintegration/rst 1 0
force -freeze sim:/simpleintegration/int 0 0
run
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /simpleintegration/f/ic
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /simpleintegration/f/ic
force -freeze sim:/simpleintegration/rst 0 0
run
run
run
run
run
force -freeze sim:/simpleintegration/int 1 0
run