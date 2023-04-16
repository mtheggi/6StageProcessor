add wave -position end  sim:/sp/mem_read
add wave -position end  sim:/sp/Clk
add wave -position end  sim:/sp/INTR
add wave -position end  sim:/sp/address_select
add wave -position end  sim:/sp/FunctionCode
add wave -position end  sim:/sp/data_out
add wave -position end  sim:/sp/stack_pointer
orce -freeze sim:/sp/Clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/sp/address_select 1 0
force -freeze sim:/sp/INTR 0 0
force -freeze sim:/sp/FunctionCode 000 0
run
force -freeze sim:/sp/mem_read 0 0
run
run
run
run
run
force -freeze sim:/sp/mem_read 1 0
run
force -freeze sim:/sp/INTR 1 0
force -freeze sim:/sp/mem_read 0 0
run
force -freeze sim:/sp/INTR 1 0
run
run
force -freeze sim:/sp/mem_read 1 0
force -freeze sim:/sp/INTR 0 0
force -freeze sim:/sp/FunctionCode 111 0
run
force -freeze sim:/sp/FunctionCode 111 0
run
run
force -freeze sim:/sp/FunctionCode 111 0
run
force -freeze sim:/sp/FunctionCode b111 0
run
force -freeze sim:/sp/mem_read 0 0
run
run
run
run
run
force -freeze sim:/sp/FunctionCode(2) 1 0
force -freeze sim:/sp/FunctionCode(1) 1 0
run
run

