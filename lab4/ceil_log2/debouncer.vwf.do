vcom -2008 -work work sync_tb.vhd
vsim -novopt -c -t 1ps -L cycloneive -L altera -L altera_mf -L 220model -L sgate -L altera_lnsim work.sync_tb -voptargs="+acc"
add wave /*
run -all
