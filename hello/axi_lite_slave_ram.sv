`timescale 1ns/1ps
module axi_lite_slave_ram #(parameter DEPTH=16)(
input clk,input rst_n,
input [31:0] awaddr,input awvalid,output reg awready,
input [31:0] wdata,input [3:0] wstrb,input wvalid,output reg wready,
output reg [1:0] bresp,output reg bvalid,input bready,
input [31:0] araddr,input arvalid,output reg arready,
output reg [31:0] rdata,output reg [1:0] rresp,output reg rvalid,input rready);
reg [31:0] mem[0:DEPTH-1]; integer i;
wire bad_w = (awaddr[31:6]!=0);
wire bad_r = (araddr[31:6]!=0);
wire [3:0] wa=awaddr[5:2], ra=araddr[5:2];
always @(posedge clk or negedge rst_n) begin
 if(!rst_n) begin awready<=1;wready<=1;arready<=1;bvalid<=0;rvalid<=0;bresp<=0;rresp<=0;rdata<=0; for(i=0;i<DEPTH;i=i+1) mem[i]<=0; end
 else begin
   if(awvalid&&wvalid&&awready&&wready) begin
      if(bad_w) bresp<=2'b10;
      else begin
        if(wstrb[0]) mem[wa][7:0]   <= wdata[7:0];
        if(wstrb[1]) mem[wa][15:8]  <= wdata[15:8];
        if(wstrb[2]) mem[wa][23:16] <= wdata[23:16];
        if(wstrb[3]) mem[wa][31:24] <= wdata[31:24];
        bresp<=2'b00;
      end
      bvalid<=1;
   end
   if(bvalid&&bready) bvalid<=0;
   if(arvalid&&arready) begin
      if(bad_r) begin rdata<=32'hBAD0_BAD0; rresp<=2'b10; end
      else begin rdata<=mem[ra]; rresp<=2'b00; end
      rvalid<=1;
   end
   if(rvalid&&rready) rvalid<=0;
 end
end
endmodule
