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
    Port ( 
           CLK_100: in std_logic;
           data : in STD_LOGIC;
           switch0 : in STD_LOGIC;
           latch : out STD_LOGIC;
           NES_clk : out STD_LOGIC;
           A : out STD_LOGIC;
           B : out STD_LOGIC;
           Sel : out STD_LOGIC;
           Start : out STD_LOGIC;
           UP : out STD_LOGIC;
           DOWN, LEFT, RIGHT : out STD_LOGIC

           );
           
end NESctrl;

architecture Behavioral of NESctrl is
signal count: integer;
component clk_wiz_0 is
port(
    clk_in1     :   in std_logic;
    clk_out1    :   out std_logic
);
end component clk_wiz_0;

component Clock_Divider is
port ( 
clk,reset: in std_logic;
clock_out: out std_logic
);
end component;


signal clk5 : std_logic;
signal valid : std_logic;
--signal data : std_logic;

signal slow_clk : std_logic;
begin
CLK0 : clk_wiz_0 port map(
    clk_in1 => CLK_100,
    clk_out1 => clk5
);
clock_div1 : Clock_Divider
port map ( 
clk => clk5,
reset => '0',
clock_out => slow_clk
);

process(slow_clk) is
begin
--if (switch0 = '0') then
--    data <= not data_in;
--else
--    data <= data_in;
--end if;
if(rising_edge(slow_clk)) then
    case (count) is
        when 0 =>
            latch <= '1';
            valid <='0';
            count <= count + 1;
        when 1 =>
            latch <='0';
            A <= data;
            Nes_clk <='0';
            count <= count + 1;
        when 2 =>
            Nes_clk <='1';
            count <= count + 1;
        when 3 =>
            B <= data;
            Nes_clk <='0';
            count <= count + 1;
        when 4 =>
            Nes_clk <='1';
            count <= count + 1;
        when 5 =>
            Nes_clk<='0';
            sel <= data;
            count <= count + 1;
        when 6 =>
            nes_clk<='1';
            count <= count + 1;
        when 7 =>
            nes_clk<='0';
            start <= data;
            count <= count + 1;
        when 8 =>
            nes_clk<='1';
            count <= count + 1;
        when 9 =>
            nes_clk<='0';
            up <= data;
            count <= count + 1;
        when 10 =>
            nes_clk<='1';
            count <= count + 1;
        when 11 =>
            nes_clk <= '0';
            down <= data;
            count <= count + 1;
        when 12 =>
            nes_clk<='1';
            count <= count + 1;
        when 13 =>
            nes_clk <='0';
            left <= data;
            count <= count + 1;
        when 14 =>
            nes_clk<='1';
            count <= count + 1;
        when 15 =>
            nes_clk<='0';
            right <= data;
            count <= count + 1;
        when 16 =>
            count<=0;
            valid<='1';
        when others =>
            count<=0;
    end case;

end if;
end process;
--count <= 0;
end Behavioral;