onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /regstim/ReadRegister1
add wave -noupdate -radix unsigned /regstim/ReadRegister2
add wave -noupdate -radix unsigned /regstim/WriteRegister
add wave -noupdate -radix hexadecimal /regstim/WriteData
add wave -noupdate /regstim/RegWrite
add wave -noupdate /regstim/clk
add wave -noupdate -radix hexadecimal /regstim/ReadData1
add wave -noupdate -radix hexadecimal /regstim/ReadData2
add wave -noupdate /regstim/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {18766005 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
configure wave -timelineunits ps
update
WaveRestoreZoom {3276800 ps} {36044800 ps}
run -all
