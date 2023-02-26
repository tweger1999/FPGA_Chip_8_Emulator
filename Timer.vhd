library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity Timer is
port(
    Clk         : in std_logic;
    Rst         : in std_logic;
    Write       : in std_logic;
    A           : in std_logic_vector(7 downto 0);
    Output      : out std_logic_vector(7 downto 0)
    );
end entity;
 
architecture rtl of Timer is
    signal current_count : std_logic_vector(7 downto 0);
begin
 
    process(Clk,write) is
    begin
        if rising_edge(Clk) then
            if Rst = '0' then
                if Write = '1' then
                    current_count <= A;
                 elsif std_logic_vector(current_count) > "00000000" then
                        current_count <= std_logic_vector(unsigned(current_count) - 1);
                 end if;
             else
                current_count <= "00000000";
             end if;
        end if;
    end process;
    Output <= current_count;
 
end architecture;