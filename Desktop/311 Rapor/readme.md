# CENG311 – Programming Assignment 3

## Revised Single-Cycle Processor with Stack Protection

**Student ID:** 300201077
**Course:** CENG311 – Computer Architecture
**Term:** Fall 2025

---

## 1. Project Overview

This project implements a **revised single-cycle processor architecture** using **Verilog**.
The original processor design was extended to support additional instructions and to include
a **stack pointer overflow and underflow protection mechanism**.

The processor was verified through **ModelSim simulation**, and the entire system was documented
in a structured **PDF report generated from HTML**.

---

## 2. Assignment Requirements (From Project Description)

The project requires the following:

### 2.1 Processor Design

- Revised **single-cycle datapath and control units**
- Support for all previously implemented instructions
- Mandatory new instructions:
  - `sll`, `move`, `nand`
  - `blt`, `subi`, `addi`, `beqi`
- Support for unconditional jump instruction (`j`)

### 2.2 Stack Pointer Error Handling

- Detection of:
  - Stack overflow
  - Stack underflow
- Prevention of invalid memory and register writes

### 2.3 Implementation

- Entire processor implemented in **Verilog**
- Modular design using multiple Verilog files

### 2.4 Initialization Files

- Register file initialized using **Table 2**
- Data memory initialized using **Table 3**
- Instruction memory populated using encoded instructions based on the ISA

### 2.5 Reporting

The final report must include:

- Complete **Instruction Set Architecture (ISA) table**
- **Updated block diagram** illustrating datapath and control
- Explanation of stack protection logic
- Simulation and demonstration explanation

---

## 3. Implementation Steps (What Was Done)

This section explains the steps taken to meet the assignment requirements.

---

### Step 1 – Instruction Set Architecture (ISA)

- A complete ISA was defined and documented as **Table 1**
- Instructions were categorized as:
  - R-type
  - I-type
  - B-I-type
  - J-type
- Opcode and function fields were explicitly defined
- All mandatory new instructions were included

✔ Requirement satisfied: **Complete ISA table**

---

### Step 2 – Register File Initialization (Table 2)

- A register file with 32-bit registers was used
- Special-purpose registers were assigned:
  - `$sp` – Stack Pointer
  - `$spba` – Stack Base Address
  - `$spl` – Stack Pointer Limit
  - `$ra` – Return Address
- Initial register values were loaded using `initReg.dat`

✔ Requirement satisfied: **Register file initialized using Table 2**

---

### Step 3 – Data Memory & Stack Allocation (Table 3)

- Data memory was initialized according to Table 3
- Memory is byte-addressable (4 bytes per word)
- Stack memory occupies a fixed region in data memory
- Initial values were loaded using `initDM.dat`

✔ Requirement satisfied: **Data memory initialized using Table 3**

---

### Step 4 – Stack Overflow and Underflow Protection

To prevent illegal stack accesses:

- Stack lower bound is computed as:

stack_low = spba - (spl << 2)

<pre class="overflow-visible! px-0!" data-start="3313" data-end="3344"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(--spacing(9)+var(--header-height))] @w-xl/main:top-9"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>- </span><span>Overflow</span><span> condition:
</span></span></code></div></div></pre>

sp > spba

<pre class="overflow-visible! px-0!" data-start="3359" data-end="3391"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(--spacing(9)+var(--header-height))] @w-xl/main:top-9"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>- Underflow condition:</span><span>
</span></span></code></div></div></pre>

sp < stack_low

- When an error is detected:
- `MemWrite` is disabled
- `RegWrite` is disabled

This ensures memory and register safety during stack operations.

✔ Requirement satisfied: **Stack pointer error handling**

---

### Step 5 – Updated Block Diagram

- The original single-cycle datapath was extended
- Stack-related registers and comparison logic were added
- Overflow and underflow detection blocks were included
- Safe control signals (`safe_memwrite`, `safe_regwrite`) were integrated

✔ Requirement satisfied: **Updated block diagram included**

---

### Step 6 – Verilog Implementation

The processor was implemented using the following Verilog modules:

- `processor.v`
- `alu32.v`
- `control.v`
- `alucont.v`
- `signext.v`
- `shift.v`
- Multiplexer modules

All modules compiled and executed successfully in **ModelSim**.

✔ Requirement satisfied: **Entire processor implemented in Verilog**

---

### Step 7 – Simulation and Verification

- Simulation performed using **ModelSim**
- Instruction memory, data memory, and register file initialized using `.dat` files
- The following signals were monitored:
- Program Counter (PC)
- Register file contents
- Data memory contents
- Stack Pointer
- Overflow and Underflow signals
- Multiple instruction blocks were executed to verify correct operation

✔ Requirement satisfied: **Simulation and demonstration completed**

---

## 4. Report Format

- The report was written in **HTML**
- Converted to **PDF using Print-to-PDF**
- The report includes:
- ISA table
- Register file and data memory tables
- Block diagram figure
- Stack protection explanation
- Simulation discussion

✔ Requirement satisfied: **Report in PDF format**

---

## 5. Final Status

All assignment requirements have been fully implemented and verified.

- ✔ Revised processor design
- ✔ Extended instruction set
- ✔ Stack overflow / underflow protection
- ✔ Successful simulation
- ✔ Complete report

**The project is ready for submission and demonstration.**

---

## 6. Notes for Demonstration

- Simulation cycle count can be increased if necessary
- Overflow and underflow signals should be highlighted during demonstration
- Stack protection behavior can be observed during `lw` and `sw` operations

---
