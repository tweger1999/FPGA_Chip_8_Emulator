----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2023 02:55:10 PM
-- Design Name: 
-- Module Name: register_file - Behavioral
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

entity register_file is
    port(
        reg_id  : in std_logic_vector(3 downto 0);
        data_in : in std_logic_vector(7 downto 0);
        data_out : out std_logic_vector(7 downto 0);
        
        write     : in std_logic;
        rst     : in std_logic;
        clk     : in std_logic
    );
end register_file;

architecture Behavioral of register_file is

    type t_file is array (0 to 15) of std_logic_vector(7 downto 0);
    signal reg_file : t_file;
    
begin

process(Clk) is
begin
    if Rising_edge(clk) then
        if rst = '1' then
            reg_file <= (others => (others => '0'));
        elsif write = '1' then
            reg_file(to_integer(unsigned(reg_id))) <= data_in;
        else
            data_out <= reg_file(to_integer(unsigned(reg_id)));
        end if;
    end if;
end process;    

end Behavioral;
