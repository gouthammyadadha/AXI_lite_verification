`timescale 1ns/1ps
module cpu_axi_master_fsm(
input clk,input rst_n,input start,
output reg done,output reg error,
output reg [31:0] awaddr,output reg awvalid,input awready,
output reg [31:0] wdata,output reg [3:0] wstrb,output reg wvalid,input wready,
input [1:0] bresp,input bvalid,output reg bready,
output reg [31:0] araddr,output reg arvalid,input arready,
input [31:0] rdata,input [1:0] rresp,input rvalid,output reg rready);
reg [4:0] st; reg [3:0] idx; reg [31:0] exp; reg [7:0] timeout;
localparam IDLE=0,WA=1,WB=2,RA=3,RD=4,CK=5,NX=6,DN=7,ER=8;
always @(posedge clk or negedge rst_n) begin
 if(!rst_n) begin st<=IDLE;idx<=0;done<=0;error<=0;awvalid<=0;wvalid<=0;bready<=0;arvalid<=0;rready<=0;wstrb<=4'hF;timeout<=0; end
 else begin timeout<=timeout+1; case(st)
 IDLE: begin timeout<=0; if(start) begin idx<=0;done<=0;error<=0; st<=WA; end end
 WA: begin awaddr<={26'd0,idx,2'b00}; wdata<=32'h3000+idx; exp<=32'h3000+idx; awvalid<=1; wvalid<=1; if(awvalid && wvalid && awready && wready) begin awvalid<=0;wvalid<=0;bready<=1;timeout<=0;st<=WB; end end
 WB: begin if(timeout==50) begin error<=1; st<=ER; end else if(bvalid) begin bready<=0; if(bresp!=0) begin error<=1; st<=ER; end else begin timeout<=0; st<=RA; end end end
 RA: begin araddr<={26'd0,idx,2'b00}; arvalid<=1; if(arvalid && arready) begin arvalid<=0;rready<=1;timeout<=0;st<=RD; end end
 RD: begin if(timeout==50) begin error<=1; st<=ER; end else if(rvalid) begin rready<=0; if(rresp!=0) begin error<=1; st<=ER; end else st<=CK; end end
 CK: begin if(rdata!=exp) begin error<=1; st<=ER; end else st<=NX; end
 NX: begin if(idx==7) begin done<=1; st<=DN; end else begin idx<=idx+1; st<=WA; end end
 DN: st<=DN;
 ER: st<=ER;
 endcase end
end
endmodule
