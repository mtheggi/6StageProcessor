vsim work.integration
# vsim work.integration 
# Start time: 13:12:52 on Apr 17,2023
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.integration(archinteg)
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
add wave -position end  sim:/integration/clk
add wave -position end  sim:/integration/rst
add wave -position end  sim:/integration/int
add wave -position end  sim:/integration/AluSelector
add wave -position end  sim:/integration/rs
add wave -position end  sim:/integration/rt
add wave -position end  sim:/integration/rd
add wave -position end  sim:/integration/rs_data
add wave -position end  sim:/integration/rt_data
add wave -position end  sim:/integration/FD_out
add wave -position end  sim:/integration/FD_in
add wave -position end  sim:/integration/DE_out
add wave -position end  sim:/integration/DE_in
add wave -position end  sim:/integration/instruction
add wave -position end  sim:/integration/immediateVal
add wave -position end  sim:/integration/updated_PC
add wave -position end  sim:/integration/OutputPort
add wave -position end  sim:/integration/ALUResult
add wave -position 18  sim:/integration/CCROut
add wave -position end  sim:/integration/identifierBit
add wave -position end  sim:/integration/BranchFlag
add wave -position end  sim:/integration/ControllerSignal
add wave -position end  sim:/integration/ControllerSignalsofM1
add wave -position end  sim:/integration/d/RF/out1
add wave -position end  sim:/integration/d/RF/out2
add wave -position end  sim:/integration/d/RF/out3
add wave -position end  sim:/integration/d/RF/out4
add wave -position end  sim:/integration/d/RF/out5
add wave -position end  sim:/integration/d/RF/out6
add wave -position end  sim:/integration/d/RF/out7
add wave -position end  sim:/integration/d/RF/out8
add wave -position end  sim:/integration/EM1/q
add wave -position end  sim:/integration/DMaddress
add wave -position 3  sim:/integration/inport
mem load -i {D:\CCE\Junior Year\Spring 23\CMPN301 - Computer Architecture\Project\6StageProcessor - new\6StageProcessor\testcases.mem} /integration/f/ic/ram
# mem load -i {D:\collegelectures\Computer Architecture\6StageProcessor\testcases.mem} /integration/f/ic/ram
force -freeze sim:/integration/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/integration/rst 1 0
force -freeze sim:/integration/int 0 0
run
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /integration/f/ic
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /integration/f/ic
force -freeze sim:/integration/inport 'hFFFE 0
run
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Region: /integration/d/RF/loop2(7)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Region: /integration/d/RF/loop2(6)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Region: /integration/d/RF/loop2(5)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Region: /integration/d/RF/loop2(4)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Region: /integration/d/RF/loop2(3)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Region: /integration/d/RF/loop2(2)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Region: /integration/d/RF/loop2(1)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Region: /integration/d/RF/loop2(0)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /integration/f/ic
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /integration/f/ic
force -freeze sim:/integration/rst 0 0
run
run
run
run
run
run
force -freeze sim:/integration/inport 'h0001 0
run
run
run
force -freeze sim:/integration/inport 0000000000001111 0
run
force -freeze sim:/integration/inport 'h00C8 0
run
force -freeze sim:/integration/inport 0000000011111111 0
run
force -freeze sim:/integration/inport 0000000000011111 0
run
force -freeze sim:/integration/inport 'h00FC 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run