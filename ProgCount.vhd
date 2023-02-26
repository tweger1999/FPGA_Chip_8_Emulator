library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity ProgCount is
port(
    Clk    : in std_logic;
    Jmp    : in std_logic;
    nRst   : in std_logic; -- Negative reset
    Input  : in std_logic_vector(15 downto 0);
    Output : out std_logic_vector(15 downto 0)
    );
end entity;
 
architecture rtl of ProgCount is
    signal current_count : std_logic_vector(15 downto 0);
begin
 
    -- Flip-flop with synchronized reset
    process(Clk) is
    begin
 
        if rising_edge(Clk) then
            if nRst = '1' then
                current_count <= (others => '0');
            elsif Jmp = '1' then
                current_count <= Input;
            else
                current_count <= std_logic_vector(unsigned(current_count) + 1);
            end if;
        end if;
 
    end process;
    output <= current_count;
 
end architecture;