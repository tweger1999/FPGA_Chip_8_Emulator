----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2023 03:42:21 PM
-- Design Name: 
-- Module Name: register_file_tb - Behavioral
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

entity register_file_tb is
--  Port ( );
end register_file_tb;

architecture Behavioral of register_file_tb is

component register_file is
    port(
        reg_id  : in std_logic_vector(3 downto 0);
        data_in : in std_logic_vector(7 downto 0);
        data_out : out std_logic_vector(7 downto 0);
        
        write     : in std_logic;
        rst     : in std_logic;
        clk     : in std_logic
    );
end component;

signal reg_id : std_logic_vector(3 downto 0);
signal data_in : std_logic_vector(7 downto 0);
signal data_out : std_logic_vector(7 downto 0);

signal write : std_logic;
signal rst : std_logic;
signal clk : std_logic;

begin

uut : register_file
port map(
    reg_id => reg_id,
    data_in => data_in,
    data_out => data_out,
    write => write,
    rst => rst,
    clk => clk
);

clock_process :process
begin
    data_in <= "00000000";
    clk <= '0';
    write <= '0';
    reg_id <= "0000";
    rst <= '0';
    wait for 100ns;
    clk <= '1';
    wait for 50ns;
    clk <= '0';
    rst <= '1';
    wait for 50ns;
    clk <= '1';
    wait for 50ns;
    clk <= '0';
    rst <= '0';
    wait for 250ns;
    clk <= '1';
    wait for 50ns;
    
    -- Init and Reset are done, now time to wrtite to registers!
    reg_id <= "0000";
    data_in <= x"00";
    write <= '1';
    clk <= '0';
    wait for 50ns;
    clk <= '1';
    wait for 50ns;
    reg_id <= "0001";
    data_in <= x"01";
    write <= '1';
     clk <= '0';
    wait for 50ns;
    clk <= '1';
    wait for 50ns;
    reg_id <= "0010";
    data_in <= x"02";
    write <= '1';
    clk <= '0';
    wait for 50ns;
    clk <= '1';
    wait for 50ns;
    reg_id <= "0011";
    data_in <= x"03";
    write <= '1';
    clk <= '0';
    wait for 50ns;
    clk <= '1';
    wait for 50ns;
    reg_id <= "0100";
    data_in <= x"04";
    write <= '1';
     clk <= '0';
    wait for 50ns;
    clk <= '1';
    wait for 50ns;
    reg_id <= "0101";
    data_in <= x"05";
    write <= '1';
    clk <= '0';
    wait for 50ns;
    clk <= '1';
    wait for 50ns;


    -- Now read them back!!!
    data_in <= x"00";
    reg_id <= "0000";
    write <= '0';
    clk <= '0';
    wait for 50ns;
    clk <= '1';
    wait for 50ns;
    reg_id <= "0001";
    write <= '0';
     clk <= '0';
    wait for 50ns;
    clk <= '1';
    wait for 50ns;
    reg_id <= "0010";
    write <= '0';
    clk <= '0';
    wait for 50ns;
    clk <= '1';
    wait for 50ns;
    reg_id <= "0011";
    write <= '0';
    clk <= '0';
    wait for 50ns;
    clk <= '1';
    wait for 50ns;
    reg_id <= "0100";
    write <= '0';
     clk <= '0';
    wait for 50ns;
    clk <= '1';
    wait for 50ns;
    reg_id <= "0101";
    write <= '0';
    clk <= '0';
    wait for 50ns;
    clk <= '1';
    wait for 50ns;
    
    
    
    
end process;


end Behavioral;
