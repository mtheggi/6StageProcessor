vsim work.integration
# vsim work.integration 
# Start time: 21:23:12 on Apr 14,2023
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
mem load -i {D:/CCE/Junior Year/Spring 23/CMPN301 - Computer Architecture/Project/6StageProcessor - new/6StageProcessor/integration.mem} /integration/f/ic/ram
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
add wave -position end  sim:/integration/instruction
add wave -position end  sim:/integration/immediateVal
add wave -position end  sim:/integration/updated_PC
add wave -position end  sim:/integration/identifierBit
add wave -position end  sim:/integration/ControllerSignal
add wave -position 16  sim:/integration/ControllerSignalAfterMux
add wave -position end  sim:/integration/d/opcode
add wave -position end  sim:/integration/d/func
add wave -position end  sim:/integration/d/rs_sig
add wave -position end  sim:/integration/d/rt_sig
add wave -position end  sim:/integration/d/rd_sig
add wave -position end  sim:/integration/d/imm_sig
add wave -position 16  sim:/integration/FD/q
add wave -position 16  sim:/integration/ResofMux
force -freeze sim:/integration/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/integration/rst 1 0
force -freeze sim:/integration/int 0 0
run
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /integration/f/ic
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /integration/f/ic
run
run
force -freeze sim:/integration/rst 0 0
run
run
run
run
run
run