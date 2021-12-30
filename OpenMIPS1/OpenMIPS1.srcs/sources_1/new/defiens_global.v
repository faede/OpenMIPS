// Enable/Disabl Signal
`define RstEnable               1`b1
`define RstDisable              1`b0
`define ZeroWord                32`h00000000
`define WriteEnable             1`b1
`define WriteDisable            1`b0
`define ReadEnable              1`b1
`define ReadDisable             1`b0
`define ChipEnable              1`b1
`define ChipDisable             1`b0

// Bus Width
`define AluOpBus                7:0
`define AluSelBus               2:0

// Boolean
`define InstValid               1`b1
`define InstInvalid             1`b0
`define True_V                  1`b1
`define False_V                 1`b0