vsim work.integration
# vsim work.integration 
# Start time: 12:16:37 on May 16,2023
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.integration(archinteg)
# Loading work.hazarddetectionunit(behavioral)
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
# ** Warning: (vsim-3473) Component instance "reg1 : Reg11" is not bound.
#    Time: 0 ps  Iteration: 0  Instance: /integration/d/RF File: D:/CCE/Junior Year/Spring 23/CMPN301 - Computer Architecture/Project/6StageProcessor - new/6StageProcessor/RegistersFile.vhd
# ** Warning: (vsim-3473) Component instance "reg2 : Reg11" is not bound.
#    Time: 0 ps  Iteration: 0  Instance: /integration/d/RF File: D:/CCE/Junior Year/Spring 23/CMPN301 - Computer Architecture/Project/6StageProcessor - new/6StageProcessor/RegistersFile.vhd
# ** Warning: (vsim-3473) Component instance "reg3 : Reg11" is not bound.
#    Time: 0 ps  Iteration: 0  Instance: /integration/d/RF File: D:/CCE/Junior Year/Spring 23/CMPN301 - Computer Architecture/Project/6StageProcessor - new/6StageProcessor/RegistersFile.vhd
# ** Warning: (vsim-3473) Component instance "reg4 : Reg11" is not bound.
#    Time: 0 ps  Iteration: 0  Instance: /integration/d/RF File: D:/CCE/Junior Year/Spring 23/CMPN301 - Computer Architecture/Project/6StageProcessor - new/6StageProcessor/RegistersFile.vhd
# ** Warning: (vsim-3473) Component instance "reg5 : Reg11" is not bound.
#    Time: 0 ps  Iteration: 0  Instance: /integration/d/RF File: D:/CCE/Junior Year/Spring 23/CMPN301 - Computer Architecture/Project/6StageProcessor - new/6StageProcessor/RegistersFile.vhd
# ** Warning: (vsim-3473) Component instance "reg6 : Reg11" is not bound.
#    Time: 0 ps  Iteration: 0  Instance: /integration/d/RF File: D:/CCE/Junior Year/Spring 23/CMPN301 - Computer Architecture/Project/6StageProcessor - new/6StageProcessor/RegistersFile.vhd
# ** Warning: (vsim-3473) Component instance "reg7 : Reg11" is not bound.
#    Time: 0 ps  Iteration: 0  Instance: /integration/d/RF File: D:/CCE/Junior Year/Spring 23/CMPN301 - Computer Architecture/Project/6StageProcessor - new/6StageProcessor/RegistersFile.vhd
# ** Warning: (vsim-3473) Component instance "reg8 : Reg11" is not bound.
#    Time: 0 ps  Iteration: 0  Instance: /integration/d/RF File: D:/CCE/Junior Year/Spring 23/CMPN301 - Computer Architecture/Project/6StageProcessor - new/6StageProcessor/RegistersFile.vhd
# Loading work.mux8(arch3)
# Loading work.mux4(arch2)
# Loading work.counterhazard(arch_counterhazard)
# Loading work.branch(branchlogic)
# Loading work.execute(exec)
# Loading work.alu(arch4)
# Loading work.select_adder(a_my_adder)
# Loading work.ccr(controlregister)
# Loading work.forwardingunit(funit)
# Loading work.sp(behavioral)
# Loading work.datamemory(dm)
# Loading work.writebackmux(archofwritebackmux)
add wave -position insertpoint  \
sim:/integration/rst
add wave -position insertpoint  \
sim:/integration/clk
add wave -position insertpoint  \
sim:/integration/f/p1/current_address
add wave -position insertpoint  \
sim:/integration/d/RF/out1 \
sim:/integration/d/RF/out2 \
sim:/integration/d/RF/out3 \
sim:/integration/d/RF/out4 \
sim:/integration/d/RF/out5 \
sim:/integration/d/RF/out6 \
sim:/integration/d/RF/out7 \
sim:/integration/d/RF/out8
add wave -position insertpoint  \
sim:/integration/CCROut
add wave -position insertpoint  \
sim:/integration/inport
add wave -position insertpoint  \
sim:/integration/OutputPort
add wave -position insertpoint  \
sim:/integration/int
add wave -position insertpoint  \
sim:/integration/stp/stack_pointer
force -freeze sim:/integration/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/integration/rst 1 0
force -freeze sim:/integration/inport 1234 0
force -freeze sim:/integration/int 0 0
