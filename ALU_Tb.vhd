library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity ALU_Tb is
end entity;
 
architecture sim of ALU_Tb is
 
    constant ClockFrequency : integer := 100e6; -- 100 MHz
    constant ClockPeriod    : time    := 1000 ms / ClockFrequency;
 
    signal Clk    : std_logic := '1';
    signal Func   : std_logic_vector(3 downto 0) := "0001";
    signal A      : std_logic_vector(7 downto 0) := "00000110";
    signal B      : std_logic_vector(7 downto 0) := "00000101";
    signal Output : std_logic_vector(7 downto 0);
    
    
    component ALU is
    port(
    Clk    : in std_logic;
    Func  : in std_logic_vector(3 downto 0);
    A  : in std_logic_vector(7 downto 0);
    B  : in std_logic_vector(7 downto 0);
    Output : out std_logic_vector(7 downto 0)
    );
    end component;
 
begin
 
    -- The Device Under Test (DUT)
    ALU0 : ALU
    port map(
        Clk     => Clk,
        Func    => Func,
        A       => A,
        B       => B,
        Output  => Output
        );
 
    -- Process for generating the clock
--    Clk <= not Clk after ClockPeriod / 2;
 
    -- Testbench sequence
    process is
    begin
    
        --Init values
        clk <= '0';
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        Func <= "0001";
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        Func <= "0010";
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        Func <= "0011";
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        Func <= "0100";
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        Func <= "0101";
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        Func <= "0110";
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        Func <= "0111";
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        Func <= "0000";
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        wait for 20ns;
        clk <= '1';
        wait for 20 ns;
        clk <= '0';
        
        
 
        wait;
    end process;
 
end architecture;
