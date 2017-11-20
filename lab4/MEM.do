onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MEM_testbench/clk
add wave -noupdate /MEM_testbench/reset
add wave -noupdate -radix decimal /MEM_testbench/Dw
add wave -noupdate -radix decimal /MEM_testbench/MemForward
add wave -noupdate /MEM_testbench/RegWrite
add wave -noupdate -radix decimal /MEM_testbench/Rd
add wave -noupdate /MEM_testbench/OPCodeIn
add wave -noupdate -radix decimal /MEM_testbench/ALUOut
add wave -noupdate -radix decimal /MEM_testbench/DbIn
add wave -noupdate /MEM_testbench/MemWriteIn
add wave -noupdate /MEM_testbench/MOVZIn
add wave -noupdate /MEM_testbench/MOVKIn
add wave -noupdate /MEM_testbench/LDURBIn
add wave -noupdate /MEM_testbench/Mem2RegIn
add wave -noupdate /MEM_testbench/RegWriteIn
add wave -noupdate /MEM_testbench/read_enableIn
add wave -noupdate /MEM_testbench/xfer_sizeIn
add wave -noupdate -radix decimal -childformat {{{/MEM_testbench/dut/memory/mem[1023]} -radix decimal} {{/MEM_testbench/dut/memory/mem[1022]} -radix decimal} {{/MEM_testbench/dut/memory/mem[1021]} -radix decimal} {{/MEM_testbench/dut/memory/mem[1020]} -radix decimal} {{/MEM_testbench/dut/memory/mem[1019]} -radix decimal} {{/MEM_testbench/dut/memory/mem[1018]} -radix decimal} {{/MEM_testbench/dut/memory/mem[1017]} -radix decimal} {{/MEM_testbench/dut/memory/mem[1016]} -radix decimal} {{/MEM_testbench/dut/memory/mem[103]} -radix decimal} {{/MEM_testbench/dut/memory/mem[102]} -radix decimal} {{/MEM_testbench/dut/memory/mem[98]} -radix binary} {{/MEM_testbench/dut/memory/mem[97]} -radix binary} {{/MEM_testbench/dut/memory/mem[96]} -radix binary}} -expand -subitemconfig {{/MEM_testbench/dut/memory/mem[1023]} {-radix decimal} {/MEM_testbench/dut/memory/mem[1022]} {-radix decimal} {/MEM_testbench/dut/memory/mem[1021]} {-radix decimal} {/MEM_testbench/dut/memory/mem[1020]} {-radix decimal} {/MEM_testbench/dut/memory/mem[1019]} {-radix decimal} {/MEM_testbench/dut/memory/mem[1018]} {-radix decimal} {/MEM_testbench/dut/memory/mem[1017]} {-radix decimal} {/MEM_testbench/dut/memory/mem[1016]} {-radix decimal} {/MEM_testbench/dut/memory/mem[103]} {-radix decimal} {/MEM_testbench/dut/memory/mem[102]} {-radix decimal} {/MEM_testbench/dut/memory/mem[98]} {-radix binary} {/MEM_testbench/dut/memory/mem[97]} {-radix binary} {/MEM_testbench/dut/memory/mem[96]} {-radix binary}} /MEM_testbench/dut/memory/mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {901674 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {4515 ns}
