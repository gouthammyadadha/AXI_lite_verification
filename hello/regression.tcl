source scripts/common.tcl
set pass 0
for {set i 1} {$i<=5} {incr i} {
 catch {exec xrun -sv rtl/*.sv assertions/*.sv tb/*.sv -logfile logs/run_$i.log} out
 set r [parse_result logs/run_$i.log]
 puts "Run $i : $r"
 if {$r eq "PASS"} {incr pass}
}
puts "TOTAL PASS = $pass / 5"
