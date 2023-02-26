![Header](https://user-images.githubusercontent.com/87651777/221392305-486b690e-5ab1-40d6-ac23-1b9d156f5f37.png)


# Overview

Using a Zedboard FPGA, we created a hardware Chip-8 emulator that uses I2C protocol to display graphics on a monitor. 

# About The Team

----

<img align="left" width="200" src="https://user-images.githubusercontent.com/87651777/221395366-a7787fb8-26bd-465f-946d-baeb3075399f.png" />

## Nathan Henry

Program: University of Cincinnati CEAS

Major: Computer Engineer

Grade: 5th Year Senior

<div id="badges"  align="left">
  <a href="https://www.linkedin.com/in/nathan-h-henry/">
    <img src="https://img.shields.io/badge/LinkedIn-blue?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn Badge"/>
  </a>
</div>

----

<img align="left" width="200" src="https://user-images.githubusercontent.com/87651777/221395366-a7787fb8-26bd-465f-946d-baeb3075399f.png" />

## Josh Smith

Program: University of Cincinnati CEAS

Major: Electrical Engineer

Grade: 5th Year Senior

<div id="badges"  align="left">
  <a href="https://www.linkedin.com/in/joshua-smith-582538185/">
    <img src="https://img.shields.io/badge/LinkedIn-blue?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn Badge"/>
  </a>
</div>

----

<img align="left" width="200" src="https://user-images.githubusercontent.com/87651777/221395366-a7787fb8-26bd-465f-946d-baeb3075399f.png" />

## Tristan Weger

Program: University of Cincinnati CEAS

Major: Electrical Engineer

Grade: 5th Year Senior

<div id="badges"  align="left">
  <a href="https://www.linkedin.com/in/tristan-weger">
    <img src="https://img.shields.io/badge/LinkedIn-blue?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn Badge"/>
  </a>
</div>

----

# About the Project
### Inspiration
The members of the group all learned about FPGAs in class, but had no experience designing a large scale project involving them. The CHIP-8 emulator seemed like a fun and challenging project for an otherwise professional use cases of the emerging technology. 

### What it does
The CHIP-8 Emulator is a virtual machine with a collection of retro arcade games, there is also implementation to create personal games.

### Construction
We used a hardware description language to program individual components such as a program counter, display, memory, alu, instruction decoder, controller input, timer, and a stack.

### Challenges
Synthesis time for the program can be minutes long, adding valuable time to debugging times. VHDL error messages can also be cryptic, leading to intense bug finding.

### Accomplishments that we're proud of 

### What we learned 
### What's next for Chip8 FPGA Emulator

# Hardware

## Zedboard Zync-7000 FPGA Development Board
<img src="https://user-images.githubusercontent.com/87651777/221396509-1af42369-689a-42a5-91a0-bfc4bb16ccc3.png" width="500" >

  - The ZedBoard is a popular development board that features a Xilinx Zynq-7000 System on Chip (SoC) device. The Zynq-7000 combines a dual-core ARM Cortex-A9 processor with programmable logic, making it a powerful platform for embedded system design. The ZedBoard includes a range of interfaces and peripherals such as USB, Ethernet, HDMI, and audio I/O, making it suitable for a wide range of applications. Additionally, the ZedBoard is supported by a range of software development tools including the Xilinx Vivado Design Suite, which makes it easy for designers to develop and test their FPGA designs. Overall, the ZedBoard is a versatile development board that provides designers with a powerful and flexible platform for developing FPGA-based systems.

# Software

## Chip-8
<img src="https://user-images.githubusercontent.com/87651777/221398254-e43ab614-25f0-4445-adeb-a94319008508.png" width="500" >

  - Chip 8 is an interpreted programming language designed for early home computers, particularly the COSMAC VIP and Telmac 1800. It uses a simple virtual machine architecture, with programs written in hexadecimal code that are executed by an interpreter running on the target hardware. The Chip 8 system was primarily used for developing simple video games, with support for graphics, sound, and user input. While the Chip 8 system was not widely adopted in its day, it has since become a popular platform for emulation enthusiasts and hobbyists. Its simple architecture and ease of programming make it a popular choice for learning about computer architecture and low-level programming.

## Xilinx Vivado
<img src="https://user-images.githubusercontent.com/87651777/221397199-6f63e066-5215-4f59-86e7-05781f03f6dc.png" width="500" >

  - Xilinx Vivado is a popular software tool used for designing and programming Field-Programmable Gate Arrays (FPGAs) and System on Chip (SoC) devices. It provides a comprehensive suite of tools for designing and optimizing digital circuits, including a design environment, synthesis tools, simulation capabilities, and debug features. Vivado also supports high-level design languages such as C/C++ and SystemC, allowing designers to quickly implement complex designs. Additionally, Vivado includes advanced optimization features such as high-level synthesis and partial reconfiguration, which can significantly improve design efficiency and reduce development time. Overall, Xilinx Vivado is a powerful tool for digital circuit design that has become a popular choice for many FPGA and SoC designers.
