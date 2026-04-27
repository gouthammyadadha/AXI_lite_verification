source scripts/common.tcl
banner "Summary"
foreach f [glob -nocomplain logs/run_*.log] {puts "$f -> [parse_result $f]"}
