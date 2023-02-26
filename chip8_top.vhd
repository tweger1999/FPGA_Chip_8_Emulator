library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity chip8_top is
  Port (
        sys_clk         : in std_logic;
        sys_rst         : in std_logic;
        RED              : out STD_LOGIC_VECTOR( 3 downto 0) := "0000";
        GREEN            : out STD_LOGIC_VECTOR( 3 downto 0) := "0000";
        BLUE             : out STD_LOGIC_VECTOR( 3 downto 0) := "0000";
        Hsync            : out STD_LOGIC := '0';
        Vsync            : out STD_LOGIC := '0'
   );
end chip8_top;

architecture Behavioral of chip8_top is
    
    component Clock_Divider is
    port ( 
        clk,reset: in std_logic;
        clock_out: out std_logic);
    end component;
    
    component clk_wiz_5 is
    port (
    clk_in1 : in std_logic;
    clk_out1 : out std_logic
    );
    end component clk_wiz_5;
    
    
    component VGA_Out is
    Port (
        CLK_100          : in STD_LOGIC := '0' ;
        clear_screen     : in std_logic;
        x_loc            : in std_logic_vector(7 downto 0);
        y_loc            : in std_logic_vector(7 downto 0);
        byte_in          : in std_logic_vector(7 downto 0);
        draw_en          : in std_logic;
        RED              : out STD_LOGIC_VECTOR( 3 downto 0) := "0000";
        GREEN            : out STD_LOGIC_VECTOR( 3 downto 0) := "0000";
        BLUE             : out STD_LOGIC_VECTOR( 3 downto 0) := "0000";
        Hsync            : out STD_LOGIC := '0';
        Vsync            : out STD_LOGIC := '0';
        data0 : in std_logic_vector(7 downto 0);
        data1 : in std_logic_vector(7 downto 0);
        data2 : in std_logic_vector(7 downto 0);
        data3 : in std_logic_vector(7 downto 0);
        data4 : in std_logic_vector(7 downto 0);
        data5 : in std_logic_vector(7 downto 0);
        data6 : in std_logic_vector(7 downto 0);
        data7 : in std_logic_vector(7 downto 0);
        data8 : in std_logic_vector(7 downto 0);
        data9 : in std_logic_vector(7 downto 0);
        data10 : in std_logic_vector(7 downto 0);
        data11 : in std_logic_vector(7 downto 0);
        data12 : in std_logic_vector(7 downto 0);
        data13 : in std_logic_vector(7 downto 0);
        data14 : in std_logic_vector(7 downto 0);
        data15 : in std_logic_vector(7 downto 0)
    );
    end component;
        
    
    
    component ProgramCounter is
    Port ( Data_in : in STD_LOGIC_VECTOR (15 downto 0);
           Data_out : out STD_LOGIC_VECTOR (15 downto 0);
           Clk : in STD_LOGIC;
           count_enable : in std_logic;
           Reset : in STD_LOGIC;
           Jump : in STD_LOGIC);
    end component;
    
 component memory4k is
    Port ( 
           address          : in STD_LOGIC_VECTOR (11 downto 0);
           write            : in STD_LOGIC;
           data_in          : in STD_LOGIC_VECTOR (7 downto 0);
           data_out         : out STD_LOGIC_VECTOR (7 downto 0);
           data_out_next    : out STD_LOGIC_VECTOR (7 downto 0);
           clk              : in std_logic;
           rst              : in std_logic;
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
           data_index15 : out std_logic_vector(7 downto 0)
           );
end component;

component fetch_control is
    Port ( 
           inst_out : out STD_LOGIC_VECTOR (15 downto 0);
           rst : in std_logic;
           clk : in STD_LOGIC;
           mem_data : in STD_LOGIC_VECTOR (7 downto 0);
           mem_data_next : in STD_LOGIC_VECTOR (7 downto 0);
           count_enable : out std_logic;
           execute : out std_logic
           );
end component;


component register_file is
    port(
        reg_id  : in std_logic_vector(3 downto 0);
        reg_id2  : in std_logic_vector(3 downto 0);
        data_in : in std_logic_vector(7 downto 0);
        data_out : out std_logic_vector(7 downto 0);
        data_out2 : out std_logic_vector(7 downto 0);
        add_en : in std_logic;
        add_value : in std_logic_vector(7 downto 0);
        write     : in std_logic;
        rst     : in std_logic;
        clk     : in std_logic;
        x_value_index : in std_logic_vector(3 downto 0);
        y_value_index : in std_logic_vector(3 downto 0);
        x_value : out std_logic_vector(7 downto 0);
        y_value : out std_logic_vector(7 downto 0)
    );
end component;

component index_register is
    port(
        data_in : in std_logic_vector(15 downto 0);
        data_out : out std_logic_vector(15 downto 0);
        write     : in std_logic;
        rst     : in std_logic;
        clk     : in std_logic
    );
end component;


component Decoder is
    Port ( Instruction : in STD_LOGIC_VECTOR (15 downto 0);
            VGAreset: out STD_Logic;
            Jump: out STD_Logic;
            JumpAddress: out STD_LOgic_vector(11 downto 0);
            x: out STD_Logic_vector(3 downto 0);
            y: out STD_Logic_vector(3 downto 0);
            n_value : out std_logic_vector(3 downto 0);
            index_value: out STD_Logic_vector(11 downto 0);
            nn_value : out std_logic_vector(7 downto 0);
            add_en : out std_logic;
            index_set_en : out std_logic;
            draw: out STD_Logic;
            value: out STD_LOGIC_VECTOR (7 downto 0);
            setReg_value : out STD_LOGIC_VECTOR (7 downto 0);
            setReg_en    : out std_logic;
            clk: in STD_LOGIC;
            execute : in std_logic
            );
end component;
    
    
    signal program_counter_out  : std_logic_vector(15 downto 0);
    
    signal main_memory_out      : std_logic_vector(7 downto 0);
    signal main_memory_out_next      : std_logic_vector(7 downto 0);
    
    signal index_register_out   : std_logic_vector(15 downto 0);
    
    signal register_file_id : std_logic_vector(3 downto 0);
    signal register_file_data_in : std_logic_vector(7 downto 0);
    signal register_file_data_out : std_logic_vector(7 downto 0);
    signal register_file_data_out2 : std_logic_vector(7 downto 0);
    signal register_file_write : std_logic;
    
    signal count_enable : std_logic;
    
    signal current_instruction : std_logic_vector(15 downto 0);
    
    signal VGAreset : std_logic;
    signal Jump_en : std_logic;
    signal jump_address : std_logic_vector(11 downto 0);
    
    signal decoder_x_reg, decoder_y_reg : std_logic_vector(3 downto 0); 
    
   
   signal x_loc : std_logic_vector(7 downto 0);
   signal y_loc : std_logic_vector(7 downto 0);
   signal byte_in : std_logic_vector(7 downto 0);
   
   signal reg_index_tmp : std_logic_vector(11 downto 0);
   signal value, setReg : std_logic_vector(7 downto 0);
   
   signal jump_address_16 : std_logic_vector(15 downto 0);
   
   signal draw_en : std_logic;
   
   signal start_drawing : std_logic;
   signal n_value : std_logic_vector(3 downto 0);
    
    
   signal index_set_en : std_logic;
   signal index_set_value : std_logic_vector(11 downto 0);
   
   signal slow_clk : std_logic;
   
   signal clk_5 : std_logic;
   
   signal nn_value : std_logic_vector(7 downto 0);
   signal add_en : std_logic;
   
   signal y_offset_draw : std_logic_vector(3 downto 0);
   
   signal data_index0 : std_logic_vector(7 downto 0);
   signal data_index1 : std_logic_vector(7 downto 0);
   signal data_index2 : std_logic_vector(7 downto 0);
   signal data_index3 : std_logic_vector(7 downto 0);
   signal data_index4 : std_logic_vector(7 downto 0);
   signal data_index5 : std_logic_vector(7 downto 0);
   signal data_index6 : std_logic_vector(7 downto 0);
   signal data_index7 : std_logic_vector(7 downto 0);
   signal data_index8 : std_logic_vector(7 downto 0);
   signal data_index9 : std_logic_vector(7 downto 0);
   signal data_index10 : std_logic_vector(7 downto 0);
   signal data_index11 : std_logic_vector(7 downto 0);
   signal data_index12 : std_logic_vector(7 downto 0);
   signal data_index13 : std_logic_vector(7 downto 0);
   signal data_index14 : std_logic_vector(7 downto 0);
   signal data_index15 : std_logic_vector(7 downto 0);
   
    signal execute : std_logic;
begin

    clock_gen_5 : clk_wiz_5
    port map(
    clk_in1 => sys_clk,
    clk_out1 => clk_5
    );


 chip8_VGA : VGA_Out
    Port map(
        CLK_100          => sys_clk,
        clear_screen     => VGAreset,
        x_loc            => x_loc,
        y_loc            => y_loc,
        byte_in          => "10101010",
        draw_en          => draw_en,
        RED              => RED,
        GREEN            => GREEN,
        BLUE             => BLUE,
        Hsync            => Hsync,
        Vsync            => Vsync,
        data0 => data_index0,
        data1 => data_index1,
        data2 => data_index2,
        data3 => data_index3,
        data4 => data_index4,
        data5 => data_index5,
        data6 => data_index6,
        data7 => data_index7,
        data8 => data_index8,
        data9 => data_index9,
        data10 => data_index10,
        data11 => data_index11,
        data12 => data_index12,
        data13 => data_index13,
        data14 => data_index14,
        data15 => data_index15
    );
    


instruction_decoder : Decoder
    Port map( 
            Instruction     => current_instruction,
            VGAreset        => VGAreset,
            Jump            => Jump_en,
            JumpAddress     => Jump_address,
            x               => decoder_x_reg,
            y               => decoder_y_reg,
            n_value         => n_value,
            nn_value        => nn_value,
            add_en          => add_en,
            index_value     => index_set_value,
            index_set_en       => index_set_en,  
            draw            => draw_en,
            value           => value,
            setReg_value    => register_file_data_in,
            setReg_en => register_file_write,
            clk             => clk_5,
            execute => execute
     );


chip8_fetch : fetch_control
    Port map( 
           inst_out => current_instruction,
           rst => sys_rst,
           clk => clk_5,
           mem_data => main_memory_out,
           mem_data_next => main_memory_out_next,
           count_enable => count_enable,
           execute => execute
     );


chip8_PC : ProgramCounter
    Port map(
           Data_in => jump_address_16,
           Data_out => program_counter_out,
           Clk => clk_5,
           count_enable => count_enable,
           Reset => sys_rst,
           Jump => Jump_en
     );
     
     jump_address_16 <= "0000"&jump_address;
     
     
 chip8_mem : memory4k
    Port map ( 
           address          => program_counter_out(11 downto 0),
           write            => '0',
           data_in          => x"00",
           data_out         => main_memory_out,
           data_out_next    => main_memory_out_next,
           clk              => clk_5,
           rst              => sys_rst,
           index_register_in => index_register_out(11 downto 0),
           data_index0 => data_index0,
           data_index1 => data_index1,
           data_index2 => data_index2,
           data_index3 => data_index3,
           data_index4 => data_index4,
           data_index5 => data_index5,
           data_index6 => data_index6,
           data_index7 => data_index7,
           data_index8 => data_index8,
           data_index9 => data_index9,
           data_index10 => data_index10,
           data_index11 => data_index11,
           data_index12 => data_index12,
           data_index13 => data_index13,
           data_index14 => data_index14,
           data_index15 => data_index15
   );
   
   
   reg_index : index_register
    port map(
        data_in     => "0000"&index_set_value,
        data_out    => index_register_out,
        write       => index_set_en,
        rst         => sys_rst,
        clk         => clk_5
    );
     

 reg_file : register_file
    port map(
        reg_id      => decoder_x_reg,
        reg_id2 => register_file_id,
        data_in     => register_file_data_in,
        data_out    => register_file_data_out,
        data_out2    => register_file_data_out2,
        add_en => add_en,
        add_value => nn_value,
        write       => register_file_write,
        rst         => sys_rst,
        clk         => clk_5,
        x_value_index => decoder_x_reg,
        y_value_index => decoder_y_reg,
        x_value => x_loc,
        y_value => y_loc
    );
    
    

end Behavioral;
