----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2023 03:47:56 PM
-- Design Name: 
-- Module Name: counter_tb - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_tb is
--  Port ( );
end counter_tb;

architecture Behavioral of counter_tb is

component ProgramCounter is
    Port ( 
            data_in : in STD_LOGIC_VECTOR (15 downto 0);
           data_out : out STD_LOGIC_VECTOR (15 downto 0);
           reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           jump : in STD_LOGIC);
end component;

signal data_in : std_logic_vector(15 downto 0);
signal data_out : std_logic_vector(15 downto 0);
signal reset : std_logic;
signal clk : std_logic;
signal jump: std_logic;

begin

UUT: ProgramCounter
port map(
    data_in => data_in,
    data_out => data_out,
    reset => reset,
    clk => clk,
    jump => jump
);

clock_process :process
begin
    reset <= '1';
    clk <= '0';
    jump <= '0';
    data_in <= "0000000000000001";
    
    
    
    wait for 100ns;
    
    clk <= '1';
    wait for 10ns;
    reset<='0';
    wait for 50ns;
    clk <= '0';
    wait for 50ns;
    clk <= '1';
    wait for 50ns;
    clk <= '0';
    wait for 50ns;
    clk <= '1';
    wait for 50ns;
     clk <= '0';
    wait for 50ns;
    clk <= '1';
    wait for 50ns;
     clk <= '0';
    wait for 50ns;
    clk <= '1';
    wait for 50ns;
     clk <= '0';
    wait for 50ns;
    clk <= '1';
    wait for 50ns;
    
    
    data_in <= "0000000000000111";
    jump<='1';
    clk <= '0';
    wait for 50ns;
    clk <= '1';
    wait for 50ns;
    jump<='0';
    clk <= '0';
    wait for 50ns;
    clk <= '1';
    wait for 50ns;
    clk <= '0';
    wait for 50ns;
    clk <= '1';
    wait for 50ns;
     clk <= '0';
    wait for 50ns;
    clk <= '1';
    wait for 50ns;
     clk <= '0';
    wait for 50ns;
    clk <= '1';
    wait for 50ns;
     clk <= '0';
    wait for 50ns;
    clk <= '1';
    wait for 50ns;
    
end process;



end Behavioral;