add wave -position end  sim:/datamemory/WriteEnable
add wave -position end  sim:/datamemory/ReadEnable
add wave -position end  sim:/datamemory/Reset
add wave -position end  sim:/datamemory/INTR
add wave -position end  sim:/datamemory/address
add wave -position end  sim:/datamemory/dataIn
add wave -position end  sim:/datamemory/dataOut
add wave -position end  sim:/datamemory/memory
add wave -position end  sim:/datamemory/latched_address
add wave -position end  sim:/datamemory/latched_data
mem load -filltype value -filldata 1234 -fillradix hexadecimal /datamemory/memory(0)
mem load -filltype value -filldata 1235 -fillradix hexadecimal /datamemory/memory(1)
mem load -filltype value -filldata 1236 -fillradix hexadecimal /datamemory/memory(2)
mem load -filltype value -filldata 1237 -fillradix hexadecimal /datamemory/memory(3)
mem load -filltype value -filldata 1238 -fillradix hexadecimal /datamemory/memory(4)
mem load -filltype value -filldata 1239 -fillradix hexadecimal /datamemory/memory(5)
mem load -filltype value -filldata 1010 -fillradix hexadecimal /datamemory/memory(6)
mem load -filltype value -filldata AAAA -fillradix hexadecimal /datamemory/memory(7)

force -freeze sim:/datamemory/address 00A 0
force -freeze sim:/datamemory/WriteEnable 1 0
force -freeze sim:/datamemory/dataIn ABCDABCD 0
force -freeze sim:/datamemory/Reset 0 0
force -freeze sim:/datamemory/INTR 0 0

force -freeze sim:/datamemory/INTR 1 0
run
force -freeze sim:/datamemory/address 00D 0
run
force -freeze sim:/datamemory/ReadEnable 1 0
force -freeze sim:/datamemory/WriteEnable 0 0
force -freeze sim:/datamemory/address 00C 0
run
force -freeze sim:/datamemory/address 00B 0
force -freeze sim:/datamemory/INTR 0 0
run
force -freeze sim:/datamemory/INTR 1 0
force -freeze sim:/datamemory/address 00A 0
