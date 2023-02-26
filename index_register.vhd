library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity index_register is
    port(
        data_in : in std_logic_vector(15 downto 0);
        data_out : out std_logic_vector(15 downto 0);
        
        write     : in std_logic;
        rst     : in std_logic;
        clk     : in std_logic
    );
end index_register;

architecture Behavioral of index_register is

    signal current_value : std_logic_vector(15 downto 0);
    
begin

process(Clk) is
begin
    if Rising_edge(clk) then
        if rst = '1' then
            current_value <= (others=>'0');
        elsif write = '1' then
            current_value <= data_in;
        end if;
    end if;
end process;   

data_out <= current_value; 

end Behavioral;
 
