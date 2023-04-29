vsim work.integration
# End time: 15:57:36 on Apr 19,2023, Elapsed time: 0:00:58
# Errors: 0, Warnings: 3
# vsim work.integration 
# Start time: 15:57:36 on Apr 19,2023
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
# Loading work.intmux(archofintmux)
# Loading work.execute(exec)
# Loading work.alu(arch4)
# Loading work.select_adder(a_my_adder)
# Loading work.ccr(controlregister)
# Loading work.sp(behavioral)
# Loading work.datamemory(dm)
# Loading work.writebackmux(archofwritebackmux)
# vsim work.integration 
# Start time: 11:53:13 on Apr 18,2023
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
# Loading work.intmux(archofintmux)
# Loading work.execute(exec)
# Loading work.alu(arch4)
# Loading work.select_adder(a_my_adder)
# Loading work.ccr(controlregister)
# Loading work.sp(behavioral)
# Loading work.datamemory(dm)
# Loading work.writebackmux(archofwritebackmux)
add wave -position end  sim:/integration/d/RF/out1
add wave -position end  sim:/integration/d/RF/out2
add wave -position end  sim:/integration/d/RF/out3
add wave -position end  sim:/integration/d/RF/out4
add wave -position end  sim:/integration/d/RF/out5
add wave -position end  sim:/integration/d/RF/out6
add wave -position end  sim:/integration/d/RF/out7
add wave -position end  sim:/integration/d/RF/out8
add wave -position 0  sim:/integration/clk
add wave -position 1  sim:/integration/rst
add wave -position 2  sim:/integration/inport
add wave -position 3  sim:/integration/CCROut
add wave -position end  sim:/integration/DM/memory
add wave -position 3  sim:/integration/f/p1/current_address
add wave -position 3  sim:/integration/int
mem load -filltype value -filldata 0 -fillradix symbolic -skip 0 /integration/f/ic/ram
mem load -i {D:/CCE/Junior Year/Spring 23/CMPN301 - Computer Architecture/Project/6StageProcessor - new/6StageProcessor/Assembler/jump.mem} /integration/f/ic/ram
force -freeze sim:/integration/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/integration/rst 1 0
force -freeze sim:/integration/inport 'hFFFE 0
force -freeze sim:/integration/int 0 0
run
force -freeze sim:/integration/rst 0 0
run
run
run
run
run
force -freeze sim:/integration/inport 'h200 0
run
run
run
run
run
run