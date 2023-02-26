----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2023 11:36:53 PM
-- Design Name: 
-- Module Name: fetch_control - Behavioral
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

entity fetch_control is
    Port ( inst_out      : out STD_LOGIC_VECTOR (15 downto 0);
           rst           : in std_logic;
           clk           : in STD_LOGIC;
           mem_data      : in STD_LOGIC_VECTOR (7 downto 0);
           mem_data_next : in STD_LOGIC_VECTOR (7 downto 0);
           count_enable  : out std_logic;
           execute : out std_logic
           );
end fetch_control;

architecture Behavioral of fetch_control is
    signal count : integer := 0;
begin
    
    process(clk) is
    begin
    if Rising_edge(clk) then
        if rst = '1' then
            count <= 0;
            --inst_out <= x"0000";
            inst_out <= mem_data & mem_data_next; 
            count_enable <= '0';
            execute <= '0';
        elsif count = 0 then
            count_enable <= '1';
            inst_out <= mem_data & mem_data_next; 
            count <= 1;
            execute <= '0';
        elsif count = 1 then
            count_enable <= '1';
            count <= 2;
        elsif count = 2 then
            count_enable <= '0';
            execute <= '1';
            count <= 0;
        else
            count <= 0;
        end if;
       
    end if;
    end process;  
    


end Behavioral;
