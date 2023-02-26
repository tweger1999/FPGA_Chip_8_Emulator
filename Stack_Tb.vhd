----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2023 03:21:55 PM
-- Design Name: 
-- Module Name: StackTb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;

ENTITY stack_tb IS
END stack_tb;

ARCHITECTURE behavior OF stack_tb IS 
   --Inputs and outputs
   signal Clk,reset,Enable,PUSH_barPOP,Stack_Full,Stack_Empty : std_logic := '0';
   signal Data_In,Data_Out : std_logic_vector(7 downto 0) := (others => '0');
    --temporary signals
    signal i : integer := 0;
   -- Clock period definitions
   constant Clk_period : time := 10 ns;

BEGIN
    -- Instantiate the Unit Under Test (UUT)
   uut: entity work.stack PORT MAP (
          Clk => Clk,
          reset => reset,
          Enable => Enable,
          Data_In => Data_In,
          Data_Out => Data_Out,
          PUSH_barPOP => PUSH_barPOP,
          Stack_Full => Stack_Full,
          Stack_Empty => Stack_Empty
        );

   -- Clock process definitions
   Clk_process :process
   begin
        Clk <= '0';
        wait for Clk_period/2;
        Clk <= '1';
        wait for Clk_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin        
        reset <= '1';  --apply reset for one clock cycle.
        wait for clk_period;
        reset <= '0';
      wait for clk_period*3; --wait for 3 clock periods(simply)
         Enable <= '1'; --Enable stack
        wait for clk_period*3;  --wait for 3 clock periods(simply)
        PUSH_barPOP <= '1';  --Set for push operation.
        Data_In <= X"FF";  --Push something to stack.
        wait for clk_period;
        Data_In <= X"7F";  --Push something to stack.
        wait for clk_period;
          Data_In <= X"2F";  --Push something to stack.
        wait for clk_period;    
        PUSH_barPOP <= '0';  --POP two of the above pushed values.
        wait for clk_period*2;
          PUSH_barPOP <= '1';  --Set for push operation.
        Data_In <= X"12";  --Push something to stack.
        wait for clk_period;
        Data_In <= X"56";  --Push something to stack.
        wait for clk_period;    
        PUSH_barPOP <= '0';  --POP all the above pushed values.
          wait for clk_period*10;   --wait for some time.
          PUSH_barPOP <= '1';  --Set for push operation.
        Data_In <= X"04";  --Push something to stack.
        wait for clk_period;
          PUSH_barPOP <= '0';  --pop what was pushed.
          wait for clk_period*10;
           Enable <= '0';   --disable stack.
            
            wait for clk_period*10; --wait for some time.
        Enable <= '1';  --Enable the stack.
        PUSH_barPOP <= '1'; --Set for push operation.
        for i in 0 to 63 loop  --Push integers from 0 to 255 to the stack.
            Data_In <= conv_std_logic_vector(i,8);
            wait for clk_period;
        end loop;   
        Enable <= '0';  --disable the stack.
        wait for clk_period*2;
        Enable <= '1'; --re-enable the stack.
        PUSH_barPOP <= '0';  --Set for POP operation.
        for i in 0 to 63 loop  --POP all elements from stack one by one.
            wait for clk_period;
        end loop;   
        Enable <= '0'; --Disable stack.

      wait;
   end process;

END;