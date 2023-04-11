vsim work.fetch
# vsim work.fetch 
# Start time: 14:06:45 on Apr 11,2023
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.fetch(archfetch)
# Loading ieee.numeric_std(body)
# Loading work.pc(programcounter)
# Loading work.instruction_cache(sync_ram_a)
# Loading work.my_nadder(a_my_adder)
# Loading work.my_adder(a_my_adder)
# Loading work.mux2(arch1)
add wave -position end  sim:/fetch/clk
add wave -position end  sim:/fetch/rst
add wave -position end  sim:/fetch/branch
add wave -position end  sim:/fetch/branch_update
add wave -position end  sim:/fetch/inst
add wave -position end  sim:/fetch/instruction_address
add wave -position end  sim:/fetch/sequential_increment
add wave -position end  sim:/fetch/sequential_update
add wave -position end  sim:/fetch/update
mem load -i {D:/CCE/Junior Year/Spring 23/CMPN301 - Computer Architecture/Project/6StageProcessor/inst.mem} /fetch/ic/ram
force -freeze sim:/fetch/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/fetch/rst 1 0
force -freeze sim:/fetch/branch 0 0
force -freeze sim:/fetch/branch_update 0000000000000000 0
run
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /fetch/ic
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /fetch/ic
force -freeze sim:/fetch/rst 0 0
run
run
force -freeze sim:/fetch/branch 1 0
force -freeze sim:/fetch/branch_update 'h10ef 0
run
force -freeze sim:/fetch/branch_update 'h01ef 0
run
force -freeze sim:/fetch/branch 0 0
run
run
force -freeze sim:/fetch/branch_update 'd0 0
force -freeze sim:/fetch/branch 1 0
run
run
force -freeze sim:/fetch/branch 0 0
run