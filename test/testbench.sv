`timescale 1ns/1ps

module testbench();
    logic clk;
    logic reset;
    logic [31:0] WriteData, DataAdr;
    logic MemWrite;

    // Переменная для контроля таймаута (защита от зависания)
    int cycle_count = 0;
    localparam MAX_CYCLES = 10000; 

    top top_inst(
        .clk(clk),
        .reset(reset),
        .dmem_wdata(WriteData),
        .dmem_addr(DataAdr),
        .MemWrite(MemWrite)
    );

    initial begin
        $dumpfile("simulation.vcd");
        $dumpvars(0, testbench);
    end

    initial begin
        reset = 1; 
        #22; 
        reset = 0;
    end

    always begin
        clk = 1; #5; 
        clk = 0; #5;
    end

    always @(negedge clk) begin
        if (!reset) begin
            $display("[TAKT %0d] PC: 0x%h | INSTRUCTION: 0x%h", cycle_count, top_inst.pc, top_inst.instr);
            
            $display("         Регистры: x2=%0d, x3=%0d, x4=%0d, x5=%0d, x7=%0d, x9=%0d",
                     top_inst.riscv_inst.datapath_inst.regfile_unit_inst.regfile[2],
                     top_inst.riscv_inst.datapath_inst.regfile_unit_inst.regfile[3],
                     top_inst.riscv_inst.datapath_inst.regfile_unit_inst.regfile[4],
                     top_inst.riscv_inst.datapath_inst.regfile_unit_inst.regfile[5],
                     top_inst.riscv_inst.datapath_inst.regfile_unit_inst.regfile[7],
                     top_inst.riscv_inst.datapath_inst.regfile_unit_inst.regfile[9]);

            cycle_count <= cycle_count + 1;
            
            if (cycle_count >= MAX_CYCLES) begin
                $display("[TIMEOUT] Simulation stopped after %0d cycles.", MAX_CYCLES);
                $finish;
            end
        end

        if (MemWrite) begin
            if (DataAdr == 32'd100 && WriteData == 32'd25) begin
                $display("[SUCCESS] Simulation succeeded! Result 25 written to Addr 100.");
                $finish;
            end else if (DataAdr !== 32'd96) begin
                $display("[FAIL] Simulation failed. Unexpected write to Addr %0d with Data %0d", DataAdr, WriteData);
                $finish;
            end
        end
    end
endmodule
