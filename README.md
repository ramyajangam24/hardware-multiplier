# hardware-multiplier
this multiplier can be used in pocket digital calculators that holds 9 digits
36-bit Shift-and-Add MultiplierA Verilog implementation of a sequential multiplier using the shift-and-add algorithm. This module processes 36-bit inputs (representing 9-digit BCD/Hex numbers) and outputs a 72-bit product using a finite state machine (FSM).
Table of Contents:
FeaturesModule Interface (I/O)Architecture and FSMDesign Issues & Suggested FixesVerification & Test Cases
FeaturesSequential Logic: Reduces hardware area compared to combinational multipliers.Early Termination: Optimizes execution time by stopping early if the multiplier register (regb) becomes zero.Status Flags: Uses a ready signal to indicate when the module is idle or has completed execution.
Architecture and FSMThe module is implemented as a 3-state Finite State Machine (FSM):IDLE (2'b00): Monitors the start signal. Loads the internal registers rega (multiplicand) and regb (multiplier) when start transitions to high.EXEC (2'b01): Sequentially checks the least significant bit (LSB) of regb. If the LSB is 1, rega is added to the product register. Concurrently shifts rega left and regb right.DONE (2'b10): Final state indicating multiplication is finished. Asserts ready high and transitions back to IDLE.
Module Interface:
| Port Name | Direction | Data Type | Bit-Width | Functional Description |
| clk| Input | `wire` | 1 bit | Global system clock; all internal operations are synchronized to its rising edge. |
| res| Input | `wire` | 1 bit | Active-high synchronous reset; clears internal registers and drives the FSM to `IDLE`. |
| start | Input | `wire` | 1 bit | Control signal; pulsed high for one cycle to initiate the multiplication process. |
| ain| Input | `wire` | 36 bits | Multiplicand input value; represents 9 hex digits or BCD characters (9 × 4 bits). |
| bin| Input | `wire` | 36 bits | Multiplier input value; represents 9 hex digits or BCD characters (9 × 4 bits). |
|ready| Output | `reg` | 1 bit | Status flag; high when the module is waiting for data or when execution is successfully finished. |
| prod| Output | `reg` | 72 bits | Double-width product accumulation register; hold
