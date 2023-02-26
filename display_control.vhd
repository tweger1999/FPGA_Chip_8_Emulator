library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display_control is
  Port (
        start_drawing : in std_logic;
        clk : in std_logic;
        rst : in std_logic;
        byte_to_draw : out std_logic_vector(7 downto 0);
        draw_en : out std_logic;
        y_offset : out std_logic_vector(3 downto 0)
   );
end display_control;

architecture Behavioral of display_control is
    signal count : integer;
begin


    process(clk) is
    begin
    if Rising_edge(clk) then
        if rst = '1' then
            count <= 0;
        else
        
            if start_drawing = '1' then
                if count= 1 then
                       draw_en <= '1';
                elsif count = 2 then
                      draw_en <= '0';
                      count <= 0; 
                end if;
                count <= count+1;
            end if;
            
        end if;
    end if;
    end process;  
    
    y_offset <= "0000";
    
    byte_to_draw <= "11100101";


end Behavioral;
