onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sync_tb/clk
add wave -noupdate /sync_tb/rst
add wave -noupdate -radix unsigned /sync_tb/y
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
configure wave -gridperiod 2000
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
run 1000 ns
WaveRestoreZoom {0 ps} {1 us}
