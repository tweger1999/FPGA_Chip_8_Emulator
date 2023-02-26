----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2023 12:30:51 PM
-- Design Name: 
-- Module Name: ProgramCounter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ProgramCounter is
    Port ( Data_in : in STD_LOGIC_VECTOR (15 downto 0);
           Data_out : out STD_LOGIC_VECTOR (15 downto 0);
           Clk : in STD_LOGIC;
           count_enable : IN std_logic;
           Reset : in STD_LOGIC;
           Jump : in STD_LOGIC);
end ProgramCounter;

architecture Behavioral of ProgramCounter is
    signal current_count: std_logic_vector(15 downto 0); --<= unsigned(std_logic_vector 15 downto 0);
begin
process(Clk) is
begin

if Rising_edge(Clk) then
    if Reset = '1' then
        current_count <= x"01FF";
    elsif Jump='1' then
        current_count <= data_in;
    elsif count_enable = '1' then
        current_count <= STD_LOGIC_VECTOR(unsigned(Current_count)+1); 
    else
        current_count <= current_count;
    end if;
end if;
end process;


data_out <= current_count;

end Behavioral;
