# UART Transmitter and Receiver in Verilog

This project implements UART (Universal Asynchronous Receiver/Transmitter) transmitter and receiver modules on the Digilent Basys-3 Artix-7 FPGA Board using Verilog. UART Enables communication between the FPGA and other embedded systems or computers
## Project Overview

This repository contains Verilog code for both a UART transmitter and a UART receiver. The modules are designed to operate at a configurable baud rate and are capable of transmitting and receiving 8-bit data. Can handle a baud rate of 9600 to 921,600(requires higher speed grade).
## Features:

* Configurable baud rate.
* 8-bit data frame with 1 start bit, 1 stop bit, no parity bit.
* Modular design for ease of integration.
