source scripts/common.tcl
banner "Compile"
exec xrun -sv rtl/*.sv assertions/*.sv tb/*.sv -elaborate -logfile logs/compile.log
