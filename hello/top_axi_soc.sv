`timescale 1ns/1ps
module top_axi_soc(input clk,input rst_n,input start,output done,output error);
wire [31:0] awaddr,wdata,araddr,rdata; wire [3:0] wstrb; wire awvalid,awready,wvalid,wready,bvalid,bready,arvalid,arready,rvalid,rready; wire [1:0] bresp,rresp;
cpu_axi_master_fsm cpu(.clk(clk),.rst_n(rst_n),.start(start),.done(done),.error(error),.awaddr(awaddr),.awvalid(awvalid),.awready(awready),.wdata(wdata),.wstrb(wstrb),.wvalid(wvalid),.wready(wready),.bresp(bresp),.bvalid(bvalid),.bready(bready),.araddr(araddr),.arvalid(arvalid),.arready(arready),.rdata(rdata),.rresp(rresp),.rvalid(rvalid),.rready(rready));
axi_lite_slave_ram ram(.clk(clk),.rst_n(rst_n),.awaddr(awaddr),.awvalid(awvalid),.awready(awready),.wdata(wdata),.wstrb(wstrb),.wvalid(wvalid),.wready(wready),.bresp(bresp),.bvalid(bvalid),.bready(bready),.araddr(araddr),.arvalid(arvalid),.arready(arready),.rdata(rdata),.rresp(rresp),.rvalid(rvalid),.rready(rready));
endmodule
