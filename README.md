# AXI_lite_verification
AMBA Protocol
# AXI Lite / AMBA Protocol Design & Verification Project

## Overview
This project demonstrates the design and verification of an **AXI Lite (AMBA)** based communication system using **SystemVerilog**.  
The system consists of:

- **FSM Based CPU Master**
- **AXI Lite Slave RAM**
- **VALID / READY Handshake Communication**
- **Assertion-Based Verification**
- **TCL Automation Flow**
- **Simulation using Cadence Xcelium (xrun)**

The main objective of this project was to understand how modern SoC components communicate using standard bus protocols instead of simple direct RAM interfaces.

---

## Why AXI Lite Instead of Normal RAM Interface?

### Traditional RAM Interface
A normal RAM typically uses:

- Address
- Write Enable
- Read Enable
- Data In
- Data Out
- Chip Select

This is simple but less scalable for large SoC systems.

### AXI Lite / AMBA Interface
AXI Lite uses separated communication channels with VALID/READY handshaking for better modularity, scalability, and integration.

### 5 Independent Channels

| Channel | Purpose |
|--------|---------|
| AW | Write Address |
| WDATA | Write Data |
| BRESP | Write Response |
| AR | Read Address |
| RDATA / RRESP | Read Data Response |

---

## Project Architecture

CPU Master FSM generates:

- Write Transactions
- Read Transactions
- Address Control
- Handshake Logic

Slave RAM handles:

- Memory Storage
- Write Acceptance
- Read Response
- Protocol Response Signals

---

## Verification Features

### Assertions Used

- VALID must wait until READY
- Address stability during handshake
- Correct write response timing
- Correct read response timing
- Reset behavior checks

### Debug Methods

- Waveform Analysis
- Console Logs
- Simulation History
- Regression Runs

---

## TCL Automation Flow

Used TCL scripting for:

- Compile and Run
- xrun Execution
- Regression Runs
- Log Generation
- Wave Dumping
- GUI Launch
- Run Console Control

Example:

tclsh scripts/run_console.tcl
