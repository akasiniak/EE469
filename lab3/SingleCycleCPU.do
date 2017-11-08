onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SingleCycleCPU_testbench/dut/clk
add wave -noupdate /SingleCycleCPU_testbench/dut/reset
add wave -noupdate /SingleCycleCPU_testbench/dut/zero
add wave -noupdate /SingleCycleCPU_testbench/dut/negative
add wave -noupdate /SingleCycleCPU_testbench/dut/carryOut
add wave -noupdate /SingleCycleCPU_testbench/dut/overflow
add wave -noupdate /SingleCycleCPU_testbench/dut/Reg2Loc
add wave -noupdate /SingleCycleCPU_testbench/dut/MemWrite
add wave -noupdate /SingleCycleCPU_testbench/dut/LDURB
add wave -noupdate /SingleCycleCPU_testbench/dut/MemtoReg
add wave -noupdate /SingleCycleCPU_testbench/dut/MOVZ
add wave -noupdate /SingleCycleCPU_testbench/dut/MOVK
add wave -noupdate /SingleCycleCPU_testbench/dut/RegWrite
add wave -noupdate /SingleCycleCPU_testbench/dut/read_enable
add wave -noupdate /SingleCycleCPU_testbench/dut/BrTaken
add wave -noupdate /SingleCycleCPU_testbench/dut/UncondBr
add wave -noupdate /SingleCycleCPU_testbench/dut/ALUCntrl
add wave -noupdate /SingleCycleCPU_testbench/dut/OPCode
add wave -noupdate /SingleCycleCPU_testbench/dut/ALUSrc
add wave -noupdate /SingleCycleCPU_testbench/dut/xfer_size
add wave -noupdate -childformat {{{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[31]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[30]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[29]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[28]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[27]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[26]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[25]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[24]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[23]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[22]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[21]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[20]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[19]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[18]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[17]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[16]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[15]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[14]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[13]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[12]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[11]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[10]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[9]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[8]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[7]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[6]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[5]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[4]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[3]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[2]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[1]} -radix unsigned} {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[0]} -radix unsigned}} -expand -subitemconfig {{/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[31]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[30]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[29]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[28]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[27]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[26]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[25]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[24]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[23]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[22]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[21]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[20]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[19]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[18]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[17]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[16]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[15]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[14]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[13]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[12]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[11]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[10]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[9]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[8]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[7]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[6]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[5]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[4]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[3]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[2]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[1]} {-height 15 -radix unsigned} {/SingleCycleCPU_testbench/dut/EXEC/registers/registerWires[0]} {-height 15 -radix unsigned}} /SingleCycleCPU_testbench/dut/EXEC/registers/registerWires
add wave -noupdate -radix hexadecimal {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[16]}
add wave -noupdate -radix hexadecimal {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[15]}
add wave -noupdate -radix hexadecimal {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[14]}
add wave -noupdate -radix hexadecimal {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[13]}
add wave -noupdate -radix hexadecimal {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[12]}
add wave -noupdate -radix hexadecimal {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[11]}
add wave -noupdate -radix hexadecimal {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[10]}
add wave -noupdate -radix hexadecimal {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[9]}
add wave -noupdate -radix hexadecimal {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[8]}
add wave -noupdate -radix hexadecimal {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[7]}
add wave -noupdate -radix hexadecimal {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[6]}
add wave -noupdate -radix hexadecimal {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[5]}
add wave -noupdate -radix hexadecimal {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[4]}
add wave -noupdate -radix hexadecimal {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[3]}
add wave -noupdate -radix hexadecimal {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[2]}
add wave -noupdate -radix hexadecimal {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[1]}
add wave -noupdate -radix hexadecimal {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[0]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[133]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[132]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[131]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[130]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[129]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[128]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[127]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[126]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[125]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[124]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[123]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[122]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[121]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[120]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[119]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[118]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[117]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[116]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[115]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[114]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[113]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[112]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[111]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[110]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[109]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[108]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[107]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[106]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[105]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[104]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[103]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[102]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[101]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[100]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[99]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[98]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[97]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[96]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[95]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[94]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[93]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[92]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[91]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[90]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[89]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[88]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[87]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[86]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[85]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[84]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[83]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[82]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[81]}
add wave -noupdate -radix ascii {/SingleCycleCPU_testbench/dut/EXEC/memory/mem[80]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1844194375 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 258
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
configure wave -timelineunits ns
update
WaveRestoreZoom {1820306875 ps} {1844194375 ps}
