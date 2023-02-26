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
            n_value : out std_logic_vector(3 downto 0);
            nn_value : out std_logic_vector(7 downto 0);
            add_en : out std_logic;
            index_value: out STD_Logic_vector(11 downto 0);
            index_set_en : out std_logic;
            draw: out STD_Logic;
            value: out STD_LOGIC_VECTOR (7 downto 0);
            setReg_value : out STD_LOGIC_VECTOR (7 downto 0);
            setReg_en    : out std_logic;
            clk: in STD_LOGIC;
            execute : in std_logic
            );
end Decoder;

architecture Behavioral of Decoder is
--signal Clear, Jump, Set_Reg, ADD, Set, Display: std_logic_vector( 15 downto 0);
signal OPCODE,N: std_logic_vector ( 3 downto 0);
signal NN: std_logic_vector ( 7 downto 0);
signal NNN: std_logic_vector (11 downto 0);
signal error: std_logic;

signal inst_done : std_logic := '0';
 
begin
    OPCODE <= Instruction(15 downto 12);

process(clk) is
begin
if(rising_edge(clk))  then


    x <= Instruction (11 downto 8);
    y <= Instruction (7 downto 4);
    n <= INstruction (3 downto 0);
    nn <= instruction (7 downto 0);
    nnn <= instruction (11 downto 0);


    if execute = '1' then
        case OPCODE is
        when "0000" =>
            -- Clear Screen
            VGAreset<='1';
            Jump <= '0';
            draw <= '0';
            setReg_en <= '0';
            index_set_en <= '0';
            add_en <= '0';
        when "0001" =>
            -- JUMP
            Jump <='1';
            JumpAddress <= nnn;
            VGAreset<='0';
            draw <= '0';
            setReg_en <= '0';
            index_set_en <= '0';
            add_en <= '0';
        when "0110" =>
            -- Set Register VX
            Jump <= '0';
            setReg_value<=nn;
            setReg_en <= '1';
            VGAreset<='0';
            index_set_en <= '0';
            draw <= '0';
            add_en <= '0';
        when "0111" =>
            -- Add Value to VX
            Jump <= '0';
            value<=nn;
            VGAreset<='0';
            draw <= '0';
            setReg_en <= '0';
            index_set_en <= '0';
            add_en <= '1';
        when "1010" =>
            -- A, set index register
            Jump <= '0';
            index_value<=nnn;
            index_set_en <= '1';
            VGAreset<='0';
            draw <= '0';
            setReg_en <= '0';
            add_en <= '0';
        when "1101" =>
            -- Display
            Jump <= '0';
            draw <= '1';
            VGAreset<='0';
            index_set_en <= '0';
            setReg_en <= '0';
            add_en <= '0';
        when others =>
            Jump <= '0';
            draw <= '0';
            Error<='1';
            index_set_en <= '0';
            VGAreset<='0';
            setReg_en <= '0';
            add_en <= '0';
        end case;
    else
            Jump <= '0';
            draw <= '0';
            index_set_en <= '0';
            VGAreset<='0';
            setReg_en <= '0';
            add_en <= '0';
    end if;
    end if;
end process;

nn_value <= nn;
end Behavioral;
