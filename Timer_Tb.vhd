library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity Timer_Tb is
end entity;
 
architecture sim of Timer_Tb is
 
--    constant ClockFrequency : integer := 100e6; -- 100 MHz
--    constant ClockPeriod    : time    := 1000 ms / ClockFrequency;
 
    signal Clk          : std_logic := '1';
    signal Rst          : std_logic := '0';
    signal Write        : std_logic := '0';
    signal A            : std_logic_vector(7 downto 0) := "00001000";
    signal Output       : std_logic_vector(7 downto 0);
    
    
    component Timer is
    port(
    Clk         : in std_logic;
    Rst         : in std_logic;
    Write       : in std_logic;
    A           : in std_logic_vector(7 downto 0);
    Output      : out std_logic_vector(7 downto 0)
    );
    end component;
 
begin
    -- The Device Under Test (DUT)
    Timer0 : Timer
    port map(
        Clk         => Clk,
        Rst         => Rst,
        Write       => Write,
        A           => A,
        Output      => Output
        );
 
    -- Process for generating the clock
--    Clk <= not Clk after ClockPeriod / 2;
 
    -- Testbench sequence
    process is
    begin
        --Init values
        Clk <= '0';
        Rst <= '1';
        wait for 20ns;
        Clk <= '1';
        wait for 20 ns;
        Clk <= '0';
        Rst <= '0';
        Write <= '1';
        wait for 20ns;
        Clk <= '1';
        wait for 20 ns;
        Clk <= '0';
        Write <= '0';
        wait for 20ns;
        Clk <= '1';
        wait for 20 ns;
        Clk <= '0';
        wait for 20ns;
        Clk <= '1';
        wait for 20 ns;
        Clk <= '0';
        wait for 20ns;
        Clk <= '1';
        wait for 20 ns;
        Clk <= '0';
        wait for 20ns;
        Clk <= '1';
        wait for 20 ns;
        Clk <= '0';
        Write <= '1';
        wait for 20ns;
        Clk <= '1';
        wait for 20 ns;
        Clk <= '0';
        Write <= '0';
        wait for 20ns;
        Clk <= '1';
        wait for 20 ns;
        Clk <= '0';
        wait for 20ns;
        Clk <= '1';
        wait for 20 ns;
        Clk <= '0';
        wait for 20ns;
        Clk <= '1';
        wait for 20 ns;
        Clk <= '0';
        wait for 20ns;
        Clk <= '1';
        wait for 20 ns;
        Clk <= '0';
        wait for 20ns;
        Clk <= '1';
        wait for 20 ns;
        Clk <= '0';
        Rst <= '1';
        wait for 20ns;
        Clk <= '1';
        wait for 20 ns;
        Clk <= '0';
        Rst <= '0';
        wait for 20ns;
        Clk <= '1';
        wait for 20 ns;
        Clk <= '0';
        wait for 20ns;
        Clk <= '1';
        wait for 20 ns;
        Clk <= '0';
        wait for 20ns;
        Clk <= '1';
        wait for 20 ns;

 
        wait;
    end process;
 
end architecture;