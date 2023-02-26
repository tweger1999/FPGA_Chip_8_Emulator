----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2023 08:38:36 PM
-- Design Name: 
-- Module Name: NESctrl - Behavioral
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

entity NESctrl is
    Port ( Data : in STD_LOGIC;
           latch, valid : out STD_LOGIC;
           NES_clk : out STD_LOGIC;
           clk : in STD_LOGIC;
           A : out STD_LOGIC;
           B : out STD_LOGIC;
           Sel : out STD_LOGIC;
           Start : out STD_LOGIC;
           UP : out STD_LOGIC;
           DOWN, LEFT, RIGHT : out STD_LOGIC);
end NESctrl;

architecture Behavioral of NESctrl is
signal count: integer;
begin
process(clk) is
begin
if(rising_edge(clk)) then
    if count=0 then
        latch <= '1';
        valid <='0';
        count <= count + 1;
    elsif count =1 then
        latch <='0';
        A <= data;
        count <= count + 1;
    elsif(count=2) then
    Nes_clk <='1';
    count <= count + 1;
    elsif(count=3) then
    b <= data;
    Nes_clk <='0';
    count <= count + 1;
    elsif(count=4) then
    Nes_clk <='1';
    count <= count + 1;
    elsif(count=5) then
    Nes_clk<='0';
    sel <= data;
    count <= count + 1;
    elsif count=6 then
    nes_clk<='1';
    count <= count + 1;
    elsif count=7 then
    nes_clk<='0';
    start <= data;
    count <= count + 1;
    elsif count=8 then
    nes_clk<='1';
    count <= count + 1;
    elsif count=9 then
    nes_clk<='0';
    up <= data;
    count <= count + 1;
    elsif count=10 then
    nes_clk<='1';
    count <= count + 1;
    elsif count=11 then
    nes_clk <= '0';
    down <= data;
    count <= count + 1;
    elsif count=12 then
    nes_clk<='1';
    count <= count + 1;
    elsif count=13 then
    nes_clk <='0';
    count <= count + 1;
    left <= data;
    elsif count=14 then
    nes_clk<='1';
    count <= count + 1;
    elsif count=15 then
    nes_clk<='0';
    count <= count + 1;
    right <= data;
    elsif count=16 then
    count<=0;
    valid<='1';
    else
    count<=0;
    end if;
end if;
end process;
count <= 0;
end Behavioral;
