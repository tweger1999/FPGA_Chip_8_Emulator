library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memory4k is
    Port ( 
           address  : in STD_LOGIC_VECTOR (11 downto 0);
           write    : in STD_LOGIC;
           data_in  : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           data_out_next : out STD_LOGIC_VECTOR (7 downto 0);
           
           index_register_in : in std_logic_vector(11 downto 0);
           data_index0 : out std_logic_vector(7 downto 0);
           data_index1 : out std_logic_vector(7 downto 0);
           data_index2 : out std_logic_vector(7 downto 0);
           data_index3 : out std_logic_vector(7 downto 0);
           data_index4 : out std_logic_vector(7 downto 0);
           data_index5 : out std_logic_vector(7 downto 0);
           data_index6 : out std_logic_vector(7 downto 0);
           data_index7 : out std_logic_vector(7 downto 0);
           data_index8 : out std_logic_vector(7 downto 0);
           data_index9 : out std_logic_vector(7 downto 0);
           data_index10 : out std_logic_vector(7 downto 0);
           data_index11 : out std_logic_vector(7 downto 0);
           data_index12 : out std_logic_vector(7 downto 0);
           data_index13 : out std_logic_vector(7 downto 0);
           data_index14 : out std_logic_vector(7 downto 0);
           data_index15 : out std_logic_vector(7 downto 0);
           clk : in std_logic;
           rst : in std_logic
           );
end memory4k;

architecture Behavioral of memory4k is
    type t_mem is array (0 to 4096) of std_logic_vector(7 downto 0);
    signal main_mem : t_mem := (others => (others => '0'));
    
    type t_ibm is array (0 to 131) of std_logic_vector(7 downto 0);
    signal ibm_prog : t_ibm := (
            X"00",
            X"e0",
            X"a2",
            X"2a",
            X"60",
            X"0c",
            X"61",
            X"08",
            X"d0",
            X"1f",
            X"70",
            X"09",
            X"a2",
            X"39",
            X"d0",
            X"1f",
            X"a2",
            X"48",
            X"70",
            X"08",
            X"d0",
            X"1f",
            X"70",
            X"04",
            X"a2",
            X"57",
            X"d0",
            X"1f",
            X"70",
            X"08",
            X"a2",
            X"66",
            X"d0",
            X"1f",
            X"70",
            X"08",
            X"a2",
            X"75",
            X"d0",
            X"1f",
            X"12",
            X"28",
            X"ff",
            X"00",
            X"ff",
            X"00",
            X"3c",
            X"00",
            X"3c",
            X"00",
            X"3c",
            X"00",
            X"3c",
            X"00",
            X"ff",
            X"00",
            X"ff",
            X"ff",
            X"00",
            X"ff",
            X"00",
            X"38",
            X"00",
            X"3f",
            X"00",
            X"3f",
            X"00",
            X"38",
            X"00",
            X"ff",
            X"00",
            X"ff",
            X"80",
            X"00",
            X"e0",
            X"00",
            X"e0",
            X"00",
            X"80",
            X"00",
            X"80",
            X"00",
            X"e0",
            X"00",
            X"e0",
            X"00",
            X"80",
            X"f8",
            X"00",
            X"fc",
            X"00",
            X"3e",
            X"00",
            X"3f",
            X"00",
            X"3b",
            X"00",
            X"39",
            X"00",
            X"f8",
            X"00",
            X"f8",
            X"03",
            X"00",
            X"07",
            X"00",
            X"0f",
            X"00",
            X"bf",
            X"00",
            X"fb",
            X"00",
            X"f3",
            X"00",
            X"e3",
            X"00",
            X"43",
            X"e0",
            X"00",
            X"e0",
            X"00",
            X"80",
            X"00",
            X"80",
            X"00",
            X"80",
            X"00",
            X"80",
            X"00",
            X"e0",
            X"00",
            X"e0"
        );
begin



process(clk) is
begin
    if rising_edge(clk) then
        if rst='1' then
        
            for i in main_mem'range loop
                if i>511 and i<643 then 
                    main_mem(i) <= ibm_prog(i-512); 
                else
                    main_mem(i) <= x"00";
                end if;
            end loop; 
            
        else
            if write='1' then
                main_mem(to_integer(unsigned(address))) <= data_in;
            else
                data_out      <= main_mem(to_integer(unsigned(address)));
               -- data_out_next      <= x"55";
                data_out_next <= main_mem(to_integer(unsigned(address)+1));
                
                
                data_index0 <= main_mem(to_integer(unsigned(index_register_in)));
                data_index1 <= main_mem(to_integer(unsigned(index_register_in))+1);
                data_index2 <= main_mem(to_integer(unsigned(index_register_in))+2);
                data_index3 <= main_mem(to_integer(unsigned(index_register_in))+3);
                data_index4 <= main_mem(to_integer(unsigned(index_register_in))+4);
                data_index5 <= main_mem(to_integer(unsigned(index_register_in))+5);
                data_index6 <= main_mem(to_integer(unsigned(index_register_in))+6);
                data_index7 <= main_mem(to_integer(unsigned(index_register_in))+7);
                data_index8 <= main_mem(to_integer(unsigned(index_register_in))+8);
                data_index9 <= main_mem(to_integer(unsigned(index_register_in))+9);
                data_index10 <= main_mem(to_integer(unsigned(index_register_in))+10);
                data_index11 <= main_mem(to_integer(unsigned(index_register_in))+11);
                data_index12 <= main_mem(to_integer(unsigned(index_register_in))+12);
                data_index13 <= main_mem(to_integer(unsigned(index_register_in))+13);
                data_index14 <= main_mem(to_integer(unsigned(index_register_in))+14);
                data_index15 <= main_mem(to_integer(unsigned(index_register_in))+15);
                                
            end if;
        end if;
    end if;
end process;  
    

end Behavioral;
