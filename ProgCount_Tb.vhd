library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity ProgCountTb is
end entity;
 
architecture sim of ProgCountTb is
 
    constant ClockFrequency : integer := 100e6; -- 100 MHz
    constant ClockPeriod    : time    := 1000 ms / ClockFrequency;
 
    signal Clk    : std_logic := '1';
    signal Jmp    : std_logic := '0';
    signal nRst   : std_logic := '0';
    signal Input  : std_logic_vector(15 downto 0) := (others => '0');
    signal Output : std_logic_vector(15 downto 0);
    
    
    component ProgCount is
    port(
    Clk    : in std_logic;
    Jmp    : in std_logic;
    nRst   : in std_logic; -- Negative reset
    Input  : in std_logic_vector;
    Output : out std_logic_vector);
    end component;
 
begin
 
    -- The Device Under Test (DUT)
    ProgCount0 : ProgCount
    port map(
        Clk    => Clk,
        Jmp    => Jmp,
        nRst   => nRst,
        Input  => Input,
        Output => Output
        );
 
    -- Process for generating the clock
--    Clk <= not Clk after ClockPeriod / 2;
 
    -- Testbench sequence
    process is
    begin
    
        --Init values
        clk <= '0';
        nRst <= '0';
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        nRst <= '1';
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        nRst <= '0';
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        Input <= "0000000001000000";
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        Jmp <= '1';
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        Jmp <= '0';
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        
        
 
        wait;
    end process;
 
end architecture;