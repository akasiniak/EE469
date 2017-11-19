onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /datamem_testbench/address
add wave -noupdate /datamem_testbench/write_enable
add wave -noupdate /datamem_testbench/read_enable
add wave -noupdate /datamem_testbench/write_data
add wave -noupdate /datamem_testbench/xfer_size
add wave -noupdate /datamem_testbench/read_data
add wave -noupdate -radix binary /datamem_testbench/test_data
add wave -noupdate -radix binary -expand /datamem_testbench/dut/mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {137801626730 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 427
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
WaveRestoreZoom {137795092350 ps} {137829205670 ps}
