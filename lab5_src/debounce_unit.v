module debounce (SLOWCLOCK, PUSHBUTTON, SINGLEPULSEOUTPUT);

    input SLOWCLOCK, PUSHBUTTON; 
    output wire SINGLEPULSEOUTPUT;
    reg PUSHBUTTON_d, PUSHBUTTON_dd;

    always @(posedge SLOWCLOCK) begin  
        PUSHBUTTON_d <= PUSHBUTTON;
        PUSHBUTTON_dd <= PUSHBUTTON_d;
    end 

    assign SINGLEPULSEOUTPUT = PUSHBUTTON_d & ~PUSHBUTTON_dd; 

endmodule