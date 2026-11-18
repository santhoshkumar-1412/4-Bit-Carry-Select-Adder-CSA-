
# 4-Bit Carry Select Adder | Verilog HDL

<p align="center">
  <b>RTL Design | Carry Select Adder | Functional Verification</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Language-Verilog-blue?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Architecture-Carry%20Select%20Adder-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Simulation-Synopsys%20VCS-green?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Debugging-Synopsys%20Verdi-purple?style=for-the-badge" />
</p>

## 1. Project Overview

This project presents the RTL design and functional verification of a **4-Bit Carry Select Adder (CSA)** using Verilog Hardware Description Language (HDL).

The Carry Select Adder is a high-speed arithmetic architecture designed to reduce carry propagation delay by performing addition for both possible carry input values in parallel.

The design consists of two 4-bit Ripple Carry Adders (RCA):

- One RCA calculates the sum assuming Carry-in (Cin) = 0.
- Another RCA calculates the sum assuming Carry-in (Cin) = 1.

A multiplexer-based selection mechanism selects the appropriate sum and carry outputs based on the actual carry input.

The design is simulated using **Synopsys VCS**, while waveform visualization and signal-level debugging are performed using **Synopsys Verdi**.

## 2. Design Specifications

| Parameter | Description |
|---|---|
| Design Name | 4-Bit Carry Select Adder |
| Design Type | Combinational Logic |
| Architecture | Carry Select Adder |
| Input Operand A | 4-bit |
| Input Operand B | 4-bit |
| Carry Input | 1-bit |
| Sum Output | 4-bit |
| Carry Output | 1-bit |
| Internal Architecture | Two 4-bit Ripple Carry Adders |
| Selection Logic | 2:1 Multiplexer |
| HDL | Verilog |
| RTL Simulator | Synopsys VCS |
| Waveform Viewer | Synopsys Verdi |
| Waveform Format | FSDB |

## 3. Design Methodology

The Carry Select Adder performs addition using two parallel Ripple Carry Adders and a multiplexer-based output selection mechanism.

### 3.1 Ripple Carry Adder (RCA)

The Ripple Carry Adder performs binary addition using four Full Adders connected in series.

Each Full Adder generates a Sum and Carry output.

The carry output of each stage is connected to the carry input of the next stage.

**Boolean Expressions**

Sum:

S = A XOR B XOR Cin

Carry:

Cout = (A AND B) OR (A AND Cin) OR (B AND Cin)

### 3.2 Carry Select Adder Architecture

The design uses two 4-bit Ripple Carry Adders operating in parallel.

**RCA 1:**

- Assumes Carry-in = 0.
- Generates Sum0 and Cout0.

**RCA 2:**

- Assumes Carry-in = 1.
- Generates Sum1 and Cout1.

Both adders calculate their outputs simultaneously.

### 3.3 Multiplexer-Based Selection

A 2:1 multiplexer selects the appropriate sum and carry outputs based on the actual carry input.

When Cin = 0:
- Sum = Sum0
- Cout = Cout0

When Cin = 1:
- Sum = Sum1
- Cout = Cout1

**Boolean Output Expressions**

Sum:

S = Cin ? Sum1 : Sum0

Carry:

Cout = Cin ? Cout1 : Cout0

This parallel computation reduces the need to wait for carry propagation through the entire addition path before determining the appropriate result.

### 3.4 Design Architecture

```text
                  Input A
                     |
          +----------+----------+
          |                     |
          v                     v
     +----------+          +----------+
     | 4-bit    |          | 4-bit    |
     | RCA      |          | RCA      |
     | Cin = 0  |          | Cin = 1  |
     +----------+          +----------+
          |                     |
       Sum0, Cout0           Sum1, Cout1
          |                     |
          +----------+----------+
                     |
                     v
               +-----------+
Actual Cin --->| 2:1 MUX   |
               +-----------+
                     |
              +------+------+
              |             |
              v             v
            Sum[3:0]       Cout
```

## 4. RTL Module Architecture

The project consists of four Verilog modules.

| Module | Functionality |
|---|---|
| `fa` | Implements Full Adder logic |
| `bit4_rca` | Implements a 4-bit Ripple Carry Adder |
| `bit4_csa` | Implements Carry Select Adder architecture |
| `bit4_csa_tb` | Testbench for functional verification |

### 4.1 Full Adder Module

The Full Adder performs addition of three single-bit inputs and generates Sum and Carry outputs.

Boolean Expressions:

Sum = A XOR B XOR Cin

Cout = (A AND B) OR (A AND Cin) OR (B AND Cin)

### 4.2 4-Bit Ripple Carry Adder

The 4-bit RCA consists of four Full Adders connected in series.

Each stage receives the carry output from the previous stage.

The module generates a 4-bit Sum and a final Carry output.

### 4.3 4-Bit Carry Select Adder

The main module instantiates two 4-bit Ripple Carry Adders.

- First RCA operates with Cin = 0.
- Second RCA operates with Cin = 1.
- A multiplexer selects the appropriate outputs using the actual Cin input.

## 5. Repository Structure

```text
4-bit-carry-select-adder/
│
├── bit4_csa.v
│   └── RTL source code (FA, RCA and CSA)
│
├── bit4_csa_tb.v
│   └── Functional verification testbench
│
├── screenshots/
│   └── verdi_waveform.png
│
├── README.md
│
└── .gitignore
```

Generated simulation files such as FSDB databases, compiled executables and intermediate simulation directories can be maintained locally rather than committed to GitHub.

## 6. Functional Verification

A Verilog testbench is developed to verify the functional behavior of the 4-Bit Carry Select Adder.

The testbench applies different combinations of input operands and carry input values at 10 ns intervals.

### 6.1 Test Scenarios

Four test cases are implemented to verify the addition functionality.

| Test Case | A | B | Cin | Expected Sum | Expected Cout |
|---|---:|---:|:---:|---:|:---:|
| TC1 | 3 | 4 | 0 | 7 | 0 |
| TC2 | 3 | 4 | 1 | 8 | 0 |
| TC3 | 7 | 5 | 0 | 12 | 0 |
| TC4 | 5 | 8 | 1 | 14 | 0 |

### 6.2 Test Case 1: A = 3, B = 4, Cin = 0

- Inputs A = 3 and B = 4 are applied.
- Carry input is set to 0.
- The first RCA output is selected.
- Sum = 7.
- Cout = 0.

**Expected Output:**

```text
A     = 3
B     = 4
Cin   = 0
Sum   = 7
Cout  = 0
```

### 6.3 Test Case 2: A = 3, B = 4, Cin = 1

- Inputs A = 3 and B = 4 are applied.
- Carry input is set to 1.
- The second RCA output is selected.
- Sum = 8.
- Cout = 0.

**Expected Output:**

```text
A     = 3
B     = 4
Cin   = 1
Sum   = 8
Cout  = 0
```

### 6.4 Test Case 3: A = 7, B = 5, Cin = 0

- Inputs A = 7 and B = 5 are applied.
- Carry input is set to 0.
- The first RCA output is selected.
- Sum = 12.
- Cout = 0.

**Expected Output:**

```text
A     = 7
B     = 5
Cin   = 0
Sum   = 12
Cout  = 0
```

### 6.5 Test Case 4: A = 5, B = 8, Cin = 1

- Inputs A = 5 and B = 8 are applied.
- Carry input is set to 1.
- The second RCA output is selected.
- Sum = 14.
- Cout = 0.

**Expected Output:**

```text
A     = 5
B     = 8
Cin   = 1
Sum   = 14
Cout  = 0
```

### 6.6 Expected Simulation Output

```text
Time=0  A=3 B=4 Cin=0 Sum=7  Cout=0
Time=10 A=3 B=4 Cin=1 Sum=8  Cout=0
Time=20 A=7 B=5 Cin=0 Sum=12 Cout=0
Time=30 A=5 B=8 Cin=1 Sum=14 Cout=0
```

## 7. Simulation Environment

The design is simulated using Synopsys VCS, and waveform analysis is performed using Synopsys Verdi.

### 7.1 Simulation Workflow

```text
       Verilog RTL Design
               |
               v
        Verilog Testbench
               |
               v
         Synopsys VCS
               |
               v
         RTL Simulation
               |
               v
          FSDB Database
               |
               v
         Synopsys Verdi
               |
               v
        Waveform Analysis
```

### 7.2 VCS Compilation

Compile the RTL source and testbench using:

```bash
vcs -full64 -debug_access+all \
bit4_csa.v \
bit4_csa_tb.v \
-o simv
```

Ensure that the Verdi FSDB PLI integration is configured correctly when generating FSDB waveforms.

### 7.3 Execute Simulation

```bash
./simv
```

The simulation executes the testbench and displays the monitored signal values in the terminal.

### 7.4 FSDB Waveform Generation

Include the following commands in the testbench to generate an FSDB waveform:

```verilog
initial begin
    $fsdbDumpfile("bit4_csa.fsdb");
    $fsdbDumpvars(0, bit4_csa_tb);
end
```

Ensure that the appropriate FSDB PLI support is enabled during VCS compilation.

### 7.5 Open Waveform in Synopsys Verdi

To view the generated FSDB waveform:

```bash
verdi -ssf bit4_csa.fsdb &
```

The generated waveform can be explored using the Verdi waveform viewer.

## 8. Waveform Analysis

Synopsys Verdi is used to inspect and analyze the simulation waveforms.

The following signals are observed:

| Signal | Width | Description |
|---|---:|---|
| `A` | 4 bits | First input operand |
| `B` | 4 bits | Second input operand |
| `Cin` | 1 bit | Carry input |
| `S` | 4 bits | Sum output |
| `Cout` | 1 bit | Carry output |

Waveform analysis helps to:

- Observe input operand transitions.
- Verify both carry input conditions.
- Analyze parallel RCA operation.
- Verify multiplexer-based output selection.
- Check sum and carry outputs.
- Debug combinational logic functionality.

### Simulation Waveform

The following screenshot shows the simulation signals observed in Synopsys Verdi.

![4-Bit Carry Select Adder Verdi Waveform](screenshots/verdi_waveform.png)

## 9. Tools and Technologies

| Tool / Technology | Purpose |
|---|---|
| Verilog HDL | RTL design implementation |
| Full Adder | Single-bit arithmetic operation |
| Ripple Carry Adder | 4-bit binary addition |
| Carry Select Adder | High-speed adder architecture |
| Synopsys VCS | RTL compilation and simulation |
| Synopsys Verdi | Waveform visualization and debugging |
| FSDB | Simulation waveform database |
| Git | Version control |
| GitHub | Source code management and documentation |

## 10. Key Learning Outcomes

Through this project, the following concepts are explored:

- Carry Select Adder architecture.
- Full Adder implementation.
- Ripple Carry Adder design.
- Parallel arithmetic computation.
- Multiplexer-based carry selection.
- Combinational logic design.
- Structural RTL modeling using Verilog.
- Testbench development and functional verification.
- RTL simulation using Synopsys VCS.
- Waveform analysis using Synopsys Verdi.
- FSDB waveform generation and inspection.

## 11. Future Enhancements

Potential extensions to this project include:

- Extending the Carry Select Adder to 8-bit and 16-bit architectures.
- Comparing Ripple Carry, Carry Select and Carry Lookahead Adders.
- Implementing a variable-block Carry Select Adder.
- Performing RTL synthesis and area analysis.
- Evaluating propagation delay and critical paths.
- Performing gate-level simulation and timing verification.
- Comparing power, performance and area (PPA).

## 12. Author

**SANTHOSH KUMAR N A**

RTL Design | Digital Design | VLSI Engineering

- GitHub: [Your GitHub Profile](https://github.com/your-username)
- LinkedIn: [Your LinkedIn Profile](https://linkedin.com/in/your-profile)

## 13. License

This project is intended for educational and learning purposes.

You are welcome to explore, modify and extend the implementation with appropriate attribution.

---

<p align="center">
  <b>Designed with Verilog HDL | Simulated with Synopsys VCS | Debugged with Synopsys Verdi</b>
</p>

<p align="center">
  ⭐ If you find this project useful, consider starring the repository!
</p>
