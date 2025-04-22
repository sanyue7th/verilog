Install this: https://bleyer.org/icarus/

Compile the verilog file:

``` 
iverilog -o and_gate_sim and_gate.v and_gate_tb.v
```

Run the simulation:

```
vvp and_gate_sim
```

View the waveforms:

```
gtkwave and_gate.vcd
```