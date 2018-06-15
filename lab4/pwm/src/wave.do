onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pwm_tb/inst/clk
add wave -noupdate /pwm_tb/inst/rst
add wave -noupdate -radix unsigned /pwm_tb/inst/duty
add wave -noupdate /pwm_tb/inst/pwm
add wave -noupdate -radix unsigned -childformat {{/pwm_tb/inst/counter(3) -radix unsigned} {/pwm_tb/inst/counter(2) -radix unsigned} {/pwm_tb/inst/counter(1) -radix unsigned} {/pwm_tb/inst/counter(0) -radix unsigned}} -expand -subitemconfig {/pwm_tb/inst/counter(3) {-height 15 -radix unsigned} /pwm_tb/inst/counter(2) {-height 15 -radix unsigned} /pwm_tb/inst/counter(1) {-height 15 -radix unsigned} /pwm_tb/inst/counter(0) {-height 15 -radix unsigned}} /pwm_tb/inst/counter
add wave -noupdate -radix unsigned -childformat {{/pwm_tb/inst/pwm_width(3) -radix unsigned} {/pwm_tb/inst/pwm_width(2) -radix unsigned} {/pwm_tb/inst/pwm_width(1) -radix unsigned} {/pwm_tb/inst/pwm_width(0) -radix unsigned}} -expand -subitemconfig {/pwm_tb/inst/pwm_width(3) {-height 15 -radix unsigned} /pwm_tb/inst/pwm_width(2) {-height 15 -radix unsigned} /pwm_tb/inst/pwm_width(1) {-height 15 -radix unsigned} /pwm_tb/inst/pwm_width(0) {-height 15 -radix unsigned}} /pwm_tb/inst/pwm_width
add wave -noupdate /pwm_tb/inst/toggle
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {97738 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 230
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 20000
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {252 ns}
