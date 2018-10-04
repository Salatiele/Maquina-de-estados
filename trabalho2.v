//Salatiele Honorato
//matricula: 92554


//                    0
//           +-----------------+
//           |                 | 2
//           |        +-----------------+
//           |        |        |        |
//         +-v-+    +-v-+    +-+-+ 2  +-+-+ 1  +---+
//         | 0 +----> 1 +----> 2 +----> 3 <----+ 4 |
//         +---+ 0  +-+-+ 0  +^-++    ++--+    +-^-+
//                    |       | | ^ 1  |         |
//                    |       | | +----+         |
//+---+    +---+    +-v-+     | |                |
//| 5 +----> 6 +----> 3 +-----+ +----------------+
//+-^-+ 3  +---+ 3  +-+-+   2            1
//  |                 |
//  +-----------------+
//          3



module ff ( input data, input c, input r, output q);
reg q;
always @(posedge c or negedge r) 
begin
 if(r==1'b0)
  q <= 1'b0; 
 else 
  q <= data; 
end 
endmodule //End 


// ----   FSM alto nível com Case
module statem(input clk, input reset, input [1:0] a, output [2:0] s);
//input clk, reset;
//input [1:0] a;
//output [2:0] s;
reg [2:0] state;  // 3 bits de estado
parameter zero=3'd0, um=3'd1, dois=3'd2, tres=3'd3, quatro=3'd4, cinco=3'd5, seis=3'd6, sete=3'd7;

assign s = (state == zero)? 3'd0:
           (state == um)? 3'd1:
           (state == dois)? 3'd2:
           (state == tres)? 3'd3:
           (state == quatro)? 3'd4:
           (state == cinco)? 3'd5:
           (state == seis)? 3'd6: 3'd3;

always @(posedge clk or negedge reset)
     begin
          if (reset==0)
               state = zero; // arbitrario neste exemplo, nao especificado...
          else
               case (state)
                    zero:
                         if(a == 0) state = um;
                         else if(a == 1) state = tres;
                         else if(a == 2) state = um;
                         else state = cinco;
                    um:
                         if(a == 0) state = dois;
                         else if(a == 1) state = tres;
                         else if(a == 2) state = sete;
                         else state = cinco;
                    dois:
                         if(a == 0) state = zero;
                         else if(a == 1) state = quatro;
                         else if(a == 2) state = tres;
                         else state = cinco;
                    tres:
                         if(a == 0) state = zero;
                         else if(a == 1) state = dois;
                         else if(a == 2'b10) state = um;
                         else state = cinco;
                    quatro: 
                         if(a == 0) state = zero;
                         else if(a == 1) state = tres;
                         else if(a == 2) state = um;
                         else state = cinco;
                    cinco:
                         if(a == 0) state = zero;
                         else if(a == 1) state = tres;
                         else if(a == 2) state = um;
                         else state = seis;
                    seis:
                         if(a == 0) state = zero;
                         else if(a == 1) state = tres;
                         else if(a == 2) state = um;
                         else state = sete;
                    sete:
                         if(a == 0) state = zero;
                         else if(a == 1) state = tres;
                         else if(a == 2) state = dois;
                         else state = cinco;
               endcase
     end
endmodule



// FSM com portas logicas
// programar ainda....
module statePorta(input clk, input res, input [1:0] a, output [2:0] s);
wire [2:0] e;
wire [2:0] p;

assign p[0] = ~e[2]&~e[1]&~e[0]  |  ~e[1]&~a[1]&a[0]  |  ~e[1]&a[1]&~a[0]  |  e[2]&e[1]&a[0]  | ~e[2]&a[1]  | ~e[0]&a[1];

assign p[1] = ~e[2]&e[1]&~e[0]&a[1]&~a[0]  |  e[2]&e[1]&e[0]&a[1]&~a[0]  |  ~e[2]&~e[1]&e[0]&~a[0]  |  e[2]&~e[1]&e[0]&a[0]  |  e[2]&~e[1]&~e[0]&a[0]  |  ~e[1]&~a[1]&a[0]  |  e[0]&~a[1]&a[0];

assign p[2] = ~e[2]&~e[1]&e[0]&a[1]  |  ~e[2]&e[1]&~e[0]&a[0]  |  a[1]&a[0];

assign s[0]  = e[0];
assign s[1]  = e[1];
assign s[2]  = e[2]&~e[1]  |  e[2]&~e[0];

ff  e0(p[0],clk,res,e[0]);
ff  e1(p[1],clk,res,e[1]);
ff  e2(p[2],clk,res,e[2]);
endmodule 




module stateMem(input clk,input res, input [1:0] a, output [2:0] s);
reg [5:0] StateMachine [0:31];
initial
begin  // programar ainda....
StateMachine[0] = 6'h01;  StateMachine[1] = 6'h03;
StateMachine[2] = 6'h01;  StateMachine[3] = 6'h05;
StateMachine[4] = 6'h0a;  StateMachine[5] = 6'h0b;
StateMachine[6] = 6'h0f;  StateMachine[7] = 6'h0d;
StateMachine[8] = 6'h10;  StateMachine[9] =  6'h14;
StateMachine[10] = 6'h13;  StateMachine[11] = 6'h15;
StateMachine[12] = 6'h18;  StateMachine[13] = 6'h1a;
StateMachine[14] = 6'h19;  StateMachine[15] = 6'h1d;
StateMachine[16] = 6'h20;  StateMachine[17] = 6'h23;
StateMachine[18] = 6'h21;  StateMachine[19] = 6'h25;
StateMachine[20] = 6'h28;  StateMachine[21] = 6'h2b;
StateMachine[22] = 6'h29;  StateMachine[23] = 6'h2e;
StateMachine[24] = 6'h30;  StateMachine[25] = 6'h33;
StateMachine[26] = 6'h31;  StateMachine[27] = 6'h37;
StateMachine[28] = 6'h18;  StateMachine[29] = 6'h1b;
StateMachine[30] = 6'h1a; StateMachine[31] = 6'h1d;
end

wire [4:0] address; // 32 linhas , 5 bits de endereco
wire [5:0] dout;  // 6 bits de largura
assign address[1:0] = a;
assign dout = StateMachine[address];
assign s = dout[5:3];
ff st0(dout[0],clk,res,address[2]);
ff st1(dout[1],clk,res,address[3]);
ff st2(dout[2],clk,res,address[4]);
endmodule


module main;
reg c,res;
reg [1:0] a;
wire [2:0] s;
wire [2:0] s1;
wire [2:0] s2;
statem FSM(c,res,a,s);
stateMem FSM1(c,res,a,s1);
statePorta FSM2(c,res,a,s2);


initial
    c = 1'b0;
  always
    c= #(1) ~c;

// visualizar formas de onda usar gtkwave out.vcd
initial  begin
     $dumpfile ("out.vcd"); 
     $dumpvars; 
   end 

  initial 
    begin
     $monitor($time," c %b res %b a %b s %d s1 %d s2 %d",c,res,a,s,s1,s2);
      #1 res=0; a=1;
      #1 res=1;
      #10 a=1; // depois de 5 "clocks", cada clock 2 unidades de tempo
      #10 a=2;
      #10 a=2;
      #10 a=1;
      #10 a=2;
      #10 a=0;
      #10 a=2;
      #10 a=2;
      #10;
      $finish ;
    end
endmodule