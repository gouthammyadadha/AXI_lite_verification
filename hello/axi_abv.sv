module axi_abv(input clk,input rst_n,input awvalid,input awready,input [31:0] awaddr,input wvalid,input wready,input [31:0] wdata,input arvalid,input arready,input [31:0] araddr,input bvalid,input bready,input rvalid,input rready);
assert property(@(posedge clk) disable iff(!rst_n) awvalid&&!awready |=> awvalid);
assert property(@(posedge clk) disable iff(!rst_n) wvalid&&!wready |=> wvalid);
assert property(@(posedge clk) disable iff(!rst_n) arvalid&&!arready |=> arvalid);
assert property(@(posedge clk) disable iff(!rst_n) bvalid&&!bready |=> bvalid);
assert property(@(posedge clk) disable iff(!rst_n) rvalid&&!rready |=> rvalid);
assert property(@(posedge clk) disable iff(!rst_n) awvalid&&!awready |=> $stable(awaddr));
assert property(@(posedge clk) disable iff(!rst_n) wvalid&&!wready |=> $stable(wdata));
assert property(@(posedge clk) disable iff(!rst_n) arvalid&&!arready |=> $stable(araddr));
assert property(@(posedge clk) disable iff(!rst_n) (awvalid&&awready&&wvalid&&wready)|->##[1:10] bvalid);
assert property(@(posedge clk) disable iff(!rst_n) (arvalid&&arready)|->##[1:10] rvalid);
cover property(@(posedge clk) awvalid&&awready);
cover property(@(posedge clk) rvalid&&rready);
endmodule
