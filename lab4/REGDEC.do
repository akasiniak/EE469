onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /REGDEC_testbench/dut/DELAY
add wave -noupdate /REGDEC_testbench/dut/ALUA
add wave -noupdate /REGDEC_testbench/dut/ALUB
add wave -noupdate /REGDEC_testbench/dut/Db
add wave -noupdate /REGDEC_testbench/dut/OPCode
add wave -noupdate /REGDEC_testbench/dut/MemWrite
add wave -noupdate /REGDEC_testbench/dut/MOVZ
add wave -noupdate /REGDEC_testbench/dut/MOVK
add wave -noupdate /REGDEC_testbench/dut/STURB
add wave -noupdate /REGDEC_testbench/dut/Mem2Reg
add wave -noupdate /REGDEC_testbench/dut/read_enable
add wave -noupdate /REGDEC_testbench/dut/NOOP
add wave -noupdate /REGDEC_testbench/dut/zero
add wave -noupdate /REGDEC_testbench/dut/xfer_size
add wave -noupdate /REGDEC_testbench/dut/ALUCntrl
add wave -noupdate /REGDEC_testbench/dut/OPCodeIn
add wave -noupdate -radix unsigned /REGDEC_testbench/dut/ExForward
add wave -noupdate -radix unsigned /REGDEC_testbench/dut/MemForward
add wave -noupdate -radix unsigned /REGDEC_testbench/dut/WritetoReg
add wave -noupdate /REGDEC_testbench/dut/ALUSrc
add wave -noupdate /REGDEC_testbench/dut/Reg2Loc
add wave -noupdate /REGDEC_testbench/dut/clk
add wave -noupdate /REGDEC_testbench/dut/reset
add wave -noupdate /REGDEC_testbench/dut/ForwardMuxB
add wave -noupdate /REGDEC_testbench/dut/ForwardMuxA
add wave -noupdate /REGDEC_testbench/dut/MemWriteIn
add wave -noupdate /REGDEC_testbench/dut/MOVZIn
add wave -noupdate /REGDEC_testbench/dut/MOVKIn
add wave -noupdate /REGDEC_testbench/dut/STURBIn
add wave -noupdate /REGDEC_testbench/dut/Mem2RegIn
add wave -noupdate /REGDEC_testbench/dut/RegWriteIn
add wave -noupdate /REGDEC_testbench/dut/read_enableIn
add wave -noupdate /REGDEC_testbench/dut/NOOPIn
add wave -noupdate /REGDEC_testbench/dut/ALUCntrlIn
add wave -noupdate /REGDEC_testbench/dut/xfer_sizeIn
add wave -noupdate -radix unsigned /REGDEC_testbench/dut/Rd
add wave -noupdate -radix unsigned /REGDEC_testbench/dut/ImmSE
add wave -noupdate -radix unsigned /REGDEC_testbench/dut/AddrSE
add wave -noupdate -radix unsigned /REGDEC_testbench/dut/Da
add wave -noupdate -radix unsigned /REGDEC_testbench/dut/DbFromReg
add wave -noupdate -radix unsigned /REGDEC_testbench/dut/ALUSrcMuxOut
add wave -noupdate -radix unsigned /REGDEC_testbench/dut/ForwardMuxAOut
add wave -noupdate -radix unsigned /REGDEC_testbench/dut/ForwardMuxBOut
add wave -noupdate /REGDEC_testbench/dut/Reg2LocMuxOut
add wave -noupdate /REGDEC_testbench/dut/RegWrite
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {432353 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 294
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {2835 ns}
