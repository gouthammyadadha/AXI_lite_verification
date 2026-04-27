source scripts/common.tcl
banner "Console Run"
catch {exec xrun -sv rtl/*.sv assertions/*.sv tb/*.sv -coverage all -covoverwrite -access +rwc -logfile logs/run.log} out
puts "RESULT : [parse_result logs/run.log]"
