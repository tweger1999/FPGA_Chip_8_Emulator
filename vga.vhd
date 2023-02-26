library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity VGA_Out is
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
end VGA_Out;

architecture VGA_output of VGA_Out is

-- Holds Screen data
type t_Screen_Mem is array (0 to 31) of std_logic_vector(63 downto 0);
signal disp_data : t_Screen_Mem := (
    (x"AAAAAAAAAAAAAAAA"),(x"5555555555555555"),(x"AAAAAAAAAAAAAAAA"),(x"5555555555555555"),(x"AAAAAAAAAAAAAAAA"),(x"5555555555555555"),(x"AAAAAAAAAAAAAAAA"),(x"5555555555555555"),
    (x"AAAAAAAAAAAAAAAA"),(x"5555555555555555"),(x"AAAAAAAAAAAAAAAA"),(x"5555555555555555"),(x"AAAAAAAAAAAAAAAA"),(x"5555555555555555"),(x"AAAAAAAAAAAAAAAA"),(x"5555555555555555"),
    (x"AAAAAAAAAAAAAAAA"),(x"5555555555555555"),(x"AAAAAAAAAAAAAAAA"),(x"5555555555555555"),(x"AAAAAAAAAAAAAAAA"),(x"5555555555555555"),(x"AAAAAAAAAAAAAAAA"),(x"5555555555555555"),
    (x"AAAAAAAAAAAAAAAA"),(x"5555555555555555"),(x"AAAAAAAAAAAAAAAA"),(x"5555555555555555"),(x"AAAAAAAAAAAAAAAA"),(x"5555555555555555"),(x"AAAAAAAAAAAAAAAA"),(x"5555555555555555")
    );


--## 640x480 60hz pixelclock = 25.175 MHz##---
signal H_FrontPorch: unsigned (11 downto 0)     := x"010"; -- Horizontal FrontPorch is 16 pixel (010 hex == 16 pixel)
signal H_SyncPulse: unsigned (11 downto 0)      := x"060"; -- Horizontal Syncpulse is 96 pixel (060 hex == 96 pixel)
signal H_BackPorch: unsigned (11 downto 0)      := x"030"; -- Horizontal BackPorch is 48 pixel (030 hex == 48 pixel)
signal H_Display: unsigned (11 downto 0)        := x"280"; -- Horizontal Display is 640 pixel(280 hex == 640 pixel)
signal V_FrontPorch: unsigned (11 downto 0)     := x"00A"; -- Vertical FrontPorch is 10 pixel (00A hex == 10 pixel)
signal V_SyncPulse: unsigned (11 downto 0)      := x"002"; -- Vertical Syncpulse is 2 pixel (060 hex == 2 pixel)
signal V_BackPorch: unsigned (11 downto 0)      := x"021"; -- Vertical BackPorch is 33 pixel (030 hex == 33 pixel)
signal V_Display: unsigned (11 downto 0)        := x"1E0"; -- Vertical Display is 480 pixel(280 hex == 480 pixel)
signal H_pol : STD_LOGIC := '0';
signal V_pol : STD_LOGIC := '0';


signal CLK25173 : std_logic := '0';
signal PixelClock : std_logic := '0';
signal hor_counter : std_logic_vector(11 downto 0);
signal ver_counter : std_logic_vector(11 downto 0);
signal VGAHsync, VGAVsync : std_logic;
signal Hdisplayarea, Vdisplayarea : std_logic;
signal displayarea : std_logic;


signal drawPixel : std_logic;

signal line_to_draw_data : std_logic_vector(63 downto 0) := x"0000000000000000";
signal line_to_draw_data2 : std_logic_vector(63 downto 0) := x"0000000000000000";
signal line_to_draw_data3 : std_logic_vector(63 downto 0) := x"0000000000000000";
signal line_to_draw_data4 : std_logic_vector(63 downto 0) := x"0000000000000000";
signal line_to_draw_data5 : std_logic_vector(63 downto 0) := x"0000000000000000";
signal line_to_draw_data6 : std_logic_vector(63 downto 0) := x"0000000000000000";
signal line_to_draw_data7 : std_logic_vector(63 downto 0) := x"0000000000000000";
signal line_to_draw_data8 : std_logic_vector(63 downto 0) := x"0000000000000000";
signal line_to_draw_data9 : std_logic_vector(63 downto 0) := x"0000000000000000";
signal line_to_draw_data10 : std_logic_vector(63 downto 0) := x"0000000000000000";
signal line_to_draw_data11 : std_logic_vector(63 downto 0) := x"0000000000000000";
signal line_to_draw_data12 : std_logic_vector(63 downto 0) := x"0000000000000000";
signal line_to_draw_data13 : std_logic_vector(63 downto 0) := x"0000000000000000";
signal line_to_draw_data14 : std_logic_vector(63 downto 0) := x"0000000000000000";
signal line_to_draw_data15 : std_logic_vector(63 downto 0) := x"0000000000000000";


-- Component Declaration for the Pixel Clock IP
-- This will only be used in this VGA File I believe
component clk_wiz_1 is
port (
    clk_in1 : in std_logic;
    clk_out1 : out std_logic
);
end component clk_wiz_1;

begin


-- Vivado IP Clock Wizard, generated a 100MHz to 25.173 MHz clock
---------------Generate PixelClock part-------------------------
-- Use the module of CLK generator 25.173Mhz
CLK1: clk_wiz_1 port map(
    CLK_100,
    CLK25173
    );
    
    
PixelClock <= CLK25173;
---------------Generate PixelClock part-------------------------




process(PixelClock) --Use the Clock to generate Hsync and Vsync and the display area
begin

    -- Keep track of what location we are currently on in the screen
    -- We need to know where we are in order to generate sync pulses, as well as knowing when we are in valid display area.
    if (PixelClock'event and PixelClock = '1') then
        if hor_counter < STD_LOGIC_VECTOR(unsigned(H_FrontPorch)+unsigned(H_SyncPulse) + unsigned(H_BackPorch) + unsigned(H_Display)-1) then -- hor_counter <799 and ver_counter <524
            hor_counter <= std_logic_vector(unsigned(hor_counter) + to_unsigned(1,12));           
          
        else
            hor_counter <= x"000";
            if ver_counter < STD_LOGIC_VECTOR(unsigned(V_FrontPorch)+unsigned(V_SyncPulse) + unsigned(V_BackPorch) + unsigned(V_Display)-1) then -- hor_counter = 799 and ver_counter <524
                ver_counter <= std_logic_vector(unsigned(ver_counter) + to_unsigned(1,12));                                      
            else 
                ver_counter <= x"000"; -- hor_counter >= 799 and ver_counter >= 524
            end if;
    end if;
    --------------- End Counter part-------------------------



    ---------------Generate H and V sync clock-------------------------
    if hor_counter >= STD_LOGIC_VECTOR(unsigned(H_FrontPorch)) and hor_counter <= STD_LOGIC_VECTOR(unsigned(H_FrontPorch) + unsigned(H_SyncPulse) -1) then -- Horizontal Sync signal turn '1' at between begining and Front Porch
        VGAHsync <= '1'; -- horizontal sync pulse generated
    else
        VGAHsync <= '0';
    end if;
    
    if ver_counter >= STD_LOGIC_VECTOR(unsigned(V_FrontPorch)) and ver_counter <= STD_LOGIC_VECTOR(unsigned(V_FrontPorch) + unsigned(V_SyncPulse) -1) then -- Horizontal Sync signal turn '1' at between begining and Front Porch
        VGAVsync <= '1'; -- vertical sync pulse generated
    else
        VGAVsync <= '0';
    end if;
    
    case V_pol is
        when '0' => Vsync <= not VGAVsync;
        when others => Vsync <= VGAVsync;
    end case;
    
    case H_pol is
        when '0' => Hsync <= not VGAHsync;
        when others => Hsync <= VGAHsync;
    end case;
    
    ------------- End Generating sync pulses ------------------------




    -------------Dectect Display area-------------------------
    if hor_counter >= STD_LOGIC_VECTOR(unsigned(H_FrontPorch) + unsigned(H_SyncPulse) + unsigned(H_BackPorch) -1) and hor_counter <= STD_LOGIC_VECTOR(unsigned(H_FrontPorch) + unsigned(H_SyncPulse) + unsigned(H_BackPorch) + unsigned(H_Display)-1) then
        Hdisplayarea <= '1';
    else
        Hdisplayarea <= '0';
    end if;
    
    if ver_counter >= STD_LOGIC_VECTOR(unsigned(V_FrontPorch) + unsigned(V_SyncPulse) + unsigned(V_BackPorch) -1) and ver_counter <= STD_LOGIC_VECTOR(unsigned(V_FrontPorch) + unsigned(V_SyncPulse) + unsigned(V_BackPorch) + unsigned(V_Display)-1)then
        Vdisplayarea <= '1';
    else
        Vdisplayarea <= '0';
    end if;
    
    -- This lets us know we are in the display area.
    displayarea <= Hdisplayarea and Vdisplayarea;
    
    end if;
end process;
    -------------Detect Display area-------------------------
    -------------Start the drawing------------
    process(CLK_100)
    begin
    if (CLK_100'event and CLK_100 = '1') then
    
        if clear_screen = '1' then
            disp_data <= (others => (others => '0'));
        elsif draw_en = '1' then
            
            for i in 0 to 63 loop
                if (i< unsigned(x_loc)) or (i>unsigned(x_loc)+7) then
                     line_to_draw_data(i) <= '0';
                else
                    line_to_draw_data(i) <=data0( 7-to_integer(i-unsigned(x_loc) ) );
                    line_to_draw_data2(i) <= data1(7- to_integer(i-unsigned(x_loc) ) );
                    line_to_draw_data3(i) <= data2(7- to_integer(i-unsigned(x_loc) ) );
                    line_to_draw_data4(i) <= data3(7- to_integer(i-unsigned(x_loc) ) );
                    line_to_draw_data5(i) <= data4(7- to_integer(i-unsigned(x_loc) ) );
                    line_to_draw_data6(i) <= data5(7- to_integer(i-unsigned(x_loc) ) );
                    line_to_draw_data7(i) <= data6(7- to_integer(i-unsigned(x_loc) ) );
                    line_to_draw_data8(i) <= data7(7- to_integer(i-unsigned(x_loc) ) );
                    line_to_draw_data9(i) <= data8(7- to_integer(i-unsigned(x_loc) ) );
                    line_to_draw_data10(i) <= data9(7- to_integer(i-unsigned(x_loc) ) );
                    line_to_draw_data11(i) <= data10(7- to_integer(i-unsigned(x_loc) ) );
                    line_to_draw_data12(i) <= data11(7- to_integer(i-unsigned(x_loc) ) );
                    line_to_draw_data13(i) <= data12(7- to_integer(i-unsigned(x_loc) ) );
                    line_to_draw_data14(i) <= data13(7- to_integer(i-unsigned(x_loc) ) );
                    line_to_draw_data15(i) <= data14(7- to_integer(i-unsigned(x_loc) ) );
                end if;
            end loop;
            
            --disp_data(to_integer(unsigned(y_loc))) <= disp_data(to_integer(unsigned(y_loc))) xor line_to_draw_data;
            
            disp_data(to_integer(unsigned(y_loc))) <= line_to_draw_data;
            disp_data(to_integer(unsigned(y_loc))+1) <= line_to_draw_data2;
            disp_data(to_integer(unsigned(y_loc))+2) <= line_to_draw_data3;
            disp_data(to_integer(unsigned(y_loc))+3) <= line_to_draw_data4;
            disp_data(to_integer(unsigned(y_loc))+4) <= line_to_draw_data5;

            disp_data(to_integer(unsigned(y_loc))+5) <= line_to_draw_data6;
            disp_data(to_integer(unsigned(y_loc))+6) <= line_to_draw_data7;
            disp_data(to_integer(unsigned(y_loc))+7) <= line_to_draw_data8;
            disp_data(to_integer(unsigned(y_loc))+8) <= line_to_draw_data9;
            disp_data(to_integer(unsigned(y_loc))+9) <= line_to_draw_data10;
            disp_data(to_integer(unsigned(y_loc))+10) <= line_to_draw_data11;
            disp_data(to_integer(unsigned(y_loc))+11) <= line_to_draw_data12;
            disp_data(to_integer(unsigned(y_loc))+12) <= line_to_draw_data13;
            disp_data(to_integer(unsigned(y_loc))+13) <= line_to_draw_data14;
            disp_data(to_integer(unsigned(y_loc))+14) <= line_to_draw_data15;
            --disp_data(to_integer(unsigned(y_loc))+5) <= line_to_draw_data6;
            
            --disp_data(to_integer(unsigned(y_loc))) <= (others => '1');
            
        else
            -- If we are in the displayarea, decide what to draw, if not output black
            if displayarea = '1' then
            
                -- We may be in the display area, but this checks if we are in our 64x32 pixel Chip-8 display
                -- The Chip-8 Display starts 228 pixels to the right and 100 pixels from the top, and each Chip-8 "Pixel" is actually 8x8 VGA pixels
                if hor_counter >= std_logic_vector(to_unsigned(228, hor_counter'length)) and hor_counter <= std_logic_vector(to_unsigned(740, hor_counter'length)) and
                    ver_counter >= std_logic_vector(to_unsigned(100, ver_counter'length)) and ver_counter <= std_logic_vector(to_unsigned(356, ver_counter'length)) then
                    
                    -- Take the horizontal and vertical count subtract the offset and then divide by 8 in order to get an index to the screen data
                    if disp_data((to_integer(unsigned(ver_counter))-100)/8)((to_integer(unsigned(hor_counter))-228)/8) = '1' then
                            drawPixel <= '1';
                    else
                            drawPixel <= '0';              
                    end if;
    
                else
                
                    drawPixel <= '0';
                    
                end if;
                
                       
                
                -- Actually draw a pixel, experimenting with colors might be interesting
                if drawPixel='1' then
                    -- This is our "ON" Pixel
                    RED <= "0000";
                    GREEN <= "0000";
                    BLUE <= "0000";
                else
                    -- This is our "OFF" Pixel
                    RED <= "0000";
                    GREEN <= "1111";
                    BLUE <= "0000";
                end if;
                
            -- Not in Display Area
            else -- to reset the value of RGB oustside display area to 0
                RED <= "0000";
                GREEN <= "0000";
                BLUE <= "0000";
            end if;
       end if;
    end if;
    end process;
end;