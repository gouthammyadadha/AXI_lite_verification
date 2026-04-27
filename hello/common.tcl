proc banner {msg} {puts "=============================="; puts $msg; puts "=============================="}
proc parse_result {file} {
 set f [open $file r]; set txt [read $f]; close $f
 if {[string match "*FINAL_PASS*" $txt]} {return PASS}
 return FAIL
}
