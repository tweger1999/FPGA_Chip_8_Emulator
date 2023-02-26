----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2023 09:36:07 PM
-- Design Name: 
-- Module Name: Decoder - Behavioral
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

entity Decoder is
    Port ( Instruction : in STD_LOGIC_VECTOR (15 downto 0);
            VGAreset: out STD_Logic;
            Jump: out STD_Logic;
            JumpAddress: out STD_LOgic_vector(11 downto 0);
            x: out STD_Logic_vector(3 downto 0);
            y: out STD_Logic_vector(3 downto 0);
            index: out STD_Logic_vector(11 downto 0);
            draw: out STD_Logic_vector(3 downto 0);
            value: out STD_LOGIC_VECTOR (7 downto 0);
            setReg: out STD_LOGIC_VECTOR (7 downto 0);
            clk: in STD_LOGIC
            );
end Decoder;

architecture Behavioral of Decoder is
--signal Clear, Jump, Set_Reg, ADD, Set, Display: std_logic_vector( 15 downto 0);
signal OPCODE,N: std_logic_vector ( 3 downto 0);
signal NN: std_logic_vector ( 7 downto 0);
signal NNN: std_logic_vector (11 downto 0);
signal error: std_logic;
 
begin
OPCODE <= Instruction(15 downto 12);
x <= Instruction (11 downto 8);
y <= Instruction (7 downto 4);
n <= INstruction (3 downto 0);
nn <= instruction (7 downto 0);
nnn <= instruction (11 downto 0);
process(clk) is
begin
if(rising_edge(clk)) then
case OPCODE is
    when "0000" =>
    VGAreset<='1';
    when "0001" =>
    Jump <='1';
    JumpAddress <= nnn;
    when "0110" =>
    setReg<=nn;
    when "0111" =>
    value<=nn;
    when "1010" =>
    index<=nnn;
    when "1101" =>
    draw <= n;
    when others =>
    Error<='1';
    end case;
    end if;
end process;    
end Behavioral;
