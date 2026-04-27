`timescale 1ns/1ps
module tb_top;
reg clk=0; always #5 clk=~clk;
reg rst_n=0,start=0; wire done,error;
top_axi_soc dut(.clk(clk),.rst_n(rst_n),.start(start),.done(done),.error(error));
axi_abv sva(.clk(clk),.rst_n(rst_n),.awvalid(dut.awvalid),.awready(dut.awready),.awaddr(dut.awaddr),
.wvalid(dut.wvalid),.wready(dut.wready),.wdata(dut.wdata),.arvalid(dut.arvalid),.arready(dut.arready),.araddr(dut.araddr),
.bvalid(dut.bvalid),.bready(dut.bready),.rvalid(dut.rvalid),.rready(dut.rready));

integer stall;
always @(posedge clk) if(rst_n) begin
 stall=$urandom_range(0,4);
 dut.ram.awready <= (stall!=0);
 dut.ram.wready  <= (stall!=1);
 dut.ram.arready <= (stall!=2);
end

reg [31:0] sb[0:15];
integer pass_cnt=0, fail_cnt=0;
always @(posedge clk) begin
 if(dut.awvalid&&dut.awready&&dut.wvalid&&dut.wready) sb[dut.awaddr[5:2]]<=dut.wdata;
 if(dut.rvalid&&dut.rready) begin
   if(dut.rdata===sb[dut.araddr[5:2]]) begin pass_cnt++; $display("[SB_PASS] addr=%0d data=%h",dut.araddr[5:2],dut.rdata); end
   else begin fail_cnt++; $display("[SB_FAIL] addr=%0d exp=%h got=%h",dut.araddr[5:2],sb[dut.araddr[5:2]],dut.rdata); end
 end
end

covergroup cg @(posedge clk);
option.per_instance = 1;
 coverpoint dut.awvalid; coverpoint dut.wvalid; coverpoint dut.bvalid;
 coverpoint dut.arvalid; coverpoint dut.rvalid;
endgroup
cg c0;
initial begin
c0= new();
c0.set_inst_name("cpu_axi_cov");
c0.start();
end

initial begin
 $shm_open("waves.shm");
 $shm_probe("AS");
 $display("=========================================");
 $display(" AXI-Lite Verification Start");
 $display("=========================================");
 #20 rst_n=1; #20 start=1; #10 start=0; 
 wait(done||error); #40;
 if(done&&!error&&fail_cnt==0) $display("[FINAL_PASS]");
 else $display("[FINAL_FAIL]");
 $display("Scoreboard Pass=%0d Fail=%0d",pass_cnt,fail_cnt);
 $display("Coverage=%0.2f %%",c0.get_coverage());
 $finish;
end
endmodule
