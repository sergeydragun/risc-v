module mainFsm (
    input logic [31:0] op,
    output logic RegWrite,
    output logic [1:0] ALUSrcA,
    output logic [1:0] ALUSrcB,
    output logic MemWrite,
    output logic [1:0] ResultSrc,
    output logic IRWrite,
    output logic AdrSrc,
    output logic Branch,
    output logic PCUpdate,
    output logic [1:0] Aluop
);

typedef enum logic {
    Fetch = 4'd0,
    Decode = 4'd1,
    MemAdr = 4'd2,
    MemRead = 4'd3,
    MemWB = 4'd4,
    MemWrite = 4'd5,
    ExecuteR = 4'd6,
    ALUWB = 4'd7,
    BEQ = 4'd8,
    JAL: 4'd9
} state_t;

state_t current_state = Fetch, next_state = Decode;

always_comb begin
    case (current_state)
        Fetch: begin
            RegWrite = 1'b0;
            MemWrite = 1'b0;

            IRWrite = 1'b1;
            AdrSrc = 1'b0;

            Aluop = 2'b00;
            ALUSrcA = 2'b00;
            ALUSrcB = 2'b10;
            ResultSrc = 2'b10;
            PCUpdate = 1'b1;

            next_state = Decode;
        end
        Decode: begin
            IRWrite = 1'b0;
            PCUpdate = 1'b0;

            Aluop = 2'b00;
            ALUSrcA = 2'b01;
            ALUSrcB = 2'b01;

            case (op)
                7'b0000011, 7'b0100011: next_state = MemAdr;
                7'b0110011: next_state = ExecuteR;
                7'b1100011: next_state = BEQ;
                7'b1101111: next_state = JAL;
            endcase

            next_state = MemAdr;
        end
        MemAdr: begin
            Aluop = 2'b00;
            ALUSrcA = 2'b10;
            ALUSrcB = 2'b01;

            case (op)
                7'b0000011: next_state = MemRead;
                7'b0100011: next_state = MemWB;
            endcase
        end
        MemRead: begin
            ResultSrc = 2'b00;
            AdrSrc = 1'b1;

            next_state = MemWB;
        end
        MemWB: begin
            ResultSrc = 2'b01;
            RegWrite = 1'b1;

            next_state = Fetch;
        end
        MemWrite: begin
            ResultSrc = 2'b00;
            MemWrite = 1'b1;

            next_state = Fetch;
        end
        ExecuteR: begin
            ALUSrcA = 2'b10;
            ALUSrcB = 2'b00;
            ALUOp = 2'b10;

            next_state = ALUWB;
        end
        ExecuteI: begin
            ALUSrcA = 2'b10;
            ALUSrcB = 2'b01;
            ALUOp = 2'b10;

            next_state = ALUWB;
        end
        ALUWB: begin
            ResultSrc = 2'b00;
            RegWrite = 1'b1;

            next_state = Fetch;
        end
        BEQ: begin
            ALUSrcA = 10;
            ALUSrcB = 00;
            ALUOp = 01;
            ResultSrc = 00;
            Branch = 1;

            next_state = Fetch;
        end
        JAL: begin
            ALUSrcA = 01;
            ALUSrcB = 10;
            ALUOp = 00;
            ResultSrc = 00;
            PCUpdate = 1;

            next_state = ALUWB;
        end
    endcase
end

always_ff @( posedge clk ) begin
    current_state <= next_state;
end

endmodule