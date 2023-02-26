library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity ALU is
port(
    Clk    : in std_logic;
    Func  : in std_logic_vector(3 downto 0);
    A  : in std_logic_vector(7 downto 0);
    B  : in std_logic_vector(7 downto 0);
    Output : out std_logic_vector(7 downto 0)
    );
end entity;
 
architecture rtl of ALU is
    signal current_count : std_logic_vector(15 downto 0);
begin
 
    -- Flip-flop with synchronized reset
    process(Clk) is
    begin
 
        if rising_edge(Clk) then
            case Func is
                when "0001" =>
                    Output <= A OR B;
                when "0010" =>
                    Output <= A AND B;
                when "0011" =>
                    Output <= A XOR B;
                when "0100" =>
                    Output <= std_logic_vector(unsigned(A)- unsigned(B));
                when "0101" =>
                    Output <= std_logic_vector(unsigned(A)+ unsigned(B));
                when "0110" =>
                    Output <= std_logic_vector(shift_left(unsigned(A), 1));
                when "0111" =>
                    Output <= std_logic_vector(shift_right(unsigned(A), 1));
                when Others =>
                    Output <= "00000000";
 end case;
        end if;
 
    end process;
 
end architecture;