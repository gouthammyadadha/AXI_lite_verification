source scripts/common.tcl
banner "GUI Run"
exec xrun -sv rtl/*.sv assertions/*.sv tb/*.sv -gui -access +rwc -coverage all -covoverwrite -logfile logs/gui.log
