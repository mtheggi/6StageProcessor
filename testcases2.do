vsim work.integration
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
mem load -filltype value -filldata {0000000000000010 } -fillradix symbolic /integration/f/ic/ram(0)
mem load -filltype value -filldata {0000000000100000 } -fillradix symbolic /integration/f/ic/ram(1)
mem load -filltype value -filldata {0100100000000101 } -fillradix symbolic /integration/f/ic/ram(2)
mem load -filltype value -filldata 0 -fillradix symbolic /integration/f/ic/ram(3)
mem load -filltype value -filldata 0 -fillradix symbolic /integration/f/ic/ram(4)
mem load -filltype value -filldata 0 -fillradix symbolic /integration/f/ic/ram(5)
mem load -filltype value -filldata 0 -fillradix symbolic /integration/f/ic/ram(6)
mem load -filltype value -filldata 0011000101000101 -fillradix symbolic /integration/f/ic/ram(7)
mem load -skip 0 -filltype value -filldata {0000000000000000 0000000000000000 0000000000000000 0000000000000000} -fillradix symbolic -startaddress 8 -endaddress 11 /integration/f/ic/ram
mem load -skip 0 -filltype value -filldata {0000000000000000 0000000000000000 0000000000000000 0000000000000000} -fillradix symbolic -startaddress 8 -endaddress 11 /integration/f/ic/ram
mem load -filltype value -filldata 0011000101000101 -fillradix symbolic /integration/f/ic/ram(12)
mem load -filltype value -filldata {0100100000000001 } -fillradix symbolic /integration/f/ic/ram(13)
mem load -filltype value -filldata {0100100000000010 } -fillradix symbolic /integration/f/ic/ram(14)
mem load -filltype value -filldata 0100100000000011 -fillradix symbolic /integration/f/ic/ram(15)
mem load -filltype value -filldata 0100100000000100 -fillradix symbolic /integration/f/ic/ram(16)
mem load -filltype value -filldata 0100100000000101 -fillradix symbolic /integration/f/ic/ram(17)
mem load -filltype value -filldata 0 -fillradix symbolic /integration/f/ic/ram(18)
mem load -filltype value -filldata 1000110010001000 -fillradix symbolic /integration/f/ic/ram(19)
mem load -filltype value -filldata 0 -fillradix symbolic /integration/f/ic/ram(20)
mem load -filltype value -filldata {1000110100011000 } -fillradix symbolic /integration/f/ic/ram(21)
mem load -filltype value -filldata {0 } -fillradix symbolic /integration/f/ic/ram(22)
mem load -filltype value -filldata {1000110101010000 } -fillradix symbolic /integration/f/ic/ram(23)
mem load -filltype value -filldata {0011000001000010 } -fillradix symbolic /integration/f/ic/ram(24)
mem load -filltype value -filldata {0110110000001000 } -fillradix symbolic /integration/f/ic/ram(25)
mem load -filltype value -filldata {0110110000011111 } -fillradix symbolic /integration/f/ic/ram(27)
mem load -filltype value -filldata 0 -fillradix symbolic /integration/f/ic/ram(26)
mem load -filltype value -filldata 0010010010110001 -fillradix symbolic /integration/f/ic/ram(28)
mem load -filltype value -filldata {0 } -fillradix symbolic /integration/f/ic/ram(29)
mem load -filltype value -filldata 0 -fillradix symbolic /integration/f/ic/ram(30)
mem load -filltype value -filldata 0 -fillradix symbolic /integration/f/ic/ram(31)
mem load -filltype value -filldata 0 -fillradix symbolic /integration/f/ic/ram(32)
mem load -filltype value -filldata 0011000001000001 -fillradix symbolic /integration/f/ic/ram(33)
mem load -filltype value -filldata {0 } -fillradix symbolic /integration/f/ic/ram(34)
mem load -filltype value -filldata 0010010011100101 -fillradix symbolic /integration/f/ic/ram(35)
mem load -filltype value -filldata 0 -fillradix symbolic -skip 0 -startaddress 36 -endaddress 65535 /integration/f/ic/ram
force -freeze sim:/integration/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/integration/rst 1 0
force -freeze sim:/integration/inport 'hFFFE 0
#add wave -position 3  sim:/integration/ControllerSignal
#add wave -position end  sim:/integration/DE/q
#add wave -position 4  sim:/integration/EM1/q
#add wave -position 16  sim:/integration/DM/WriteEnable
#add wave -position 17  sim:/integration/DM/ReadEnable
#add wave -position 18  sim:/integration/DM/address
#add wave -position 19  sim:/integration/DM/dataIn
#add wave -position 20  sim:/integration/DM/dataOut
#add wave -position 21  sim:/integration/DM/latched_address
#add wave -position 22  sim:/integration/DM/latched_data
#add wave -position 23  sim:/integration/DM/latched_memRead
#add wave -position 24  sim:/integration/DM/latched_memWrite
#add wave -position end  sim:/integration/EM2/q
#add wave -position end  sim:/integration/DM/combineReads
force -freeze sim:/integration/int 0 0
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
run 1600 ps
force -freeze sim:/integration/inport 'h0001 0
run
force -freeze sim:/integration/inport 0000000000001111 0
run
force -freeze sim:/integration/inport 'h00C8 0
run
force -freeze sim:/integration/inport 'h001f 0
run
force -freeze sim:/integration/inport 'h00fc 0
run 2100 ps