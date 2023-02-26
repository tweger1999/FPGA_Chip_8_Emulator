library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity VGA_Test is
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
    Vsync            : out STD_LOGIC := '0'
);
end VGA_Test;

architecture VGA_output of VGA_Test is

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



-- Component Declaration for the Pixel Clock IP
-- This will only be used in this VGA File I believe
component clk_wiz_0 is
port (
    clk_in1 : in std_logic;
    clk_out1 : out std_logic
);
end component clk_wiz_0;

begin


-- Vivado IP Clock Wizard, generated a 100MHz to 25.173 MHz clock
---------------Generate PixelClock part-------------------------
-- Use the module of CLK generator 25.173Mhz
CLK1: clk_wiz_0 port map(CLK_100,CLK25173);
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
            disp_data(10) <= disp_data(10) or x"0000FFFFFFFF0000";
            disp_data(11) <= disp_data(10) or x"0000FFFFFFFF0000";
            disp_data(12) <= disp_data(10) or x"0000FFFFFFFF0000";
            disp_data(13) <= disp_data(10) or x"0000FFFFFFFF0000";
            disp_data(14) <= disp_data(10) or x"0000FFFFFFFF0000";
            disp_data(15) <= disp_data(10) or x"0000FFFFFFFF0000";
            disp_data(16) <= disp_data(10) or x"0000FFFFFFFF0000";
            disp_data(17) <= disp_data(10) or x"0000FFFFFFFF0000";
        else
            -- If we are in the displayarea, decide what to draw, if not output black
            if displayarea = '1' then
            
                -- We may be in the display area, but this checks if we are in our 64x32 pixel Chip-8 display
                -- The Chip-8 Display starts 228 pixels to the right and 100 pixels from the top, and each Chip-8 "Pixel" is actually 8x8 VGA pixels
                if hor_counter >= std_logic_vector(to_unsigned(228, hor_counter'length)) and hor_counter <= std_logic_vector(to_unsigned(740, hor_counter'length)) and
                    ver_counter >= std_logic_vector(to_unsigned(100, ver_counter'length)) and ver_counter <= std_logic_vector(to_unsigned(356, ver_counter'length)) then
                    
                    -- Take the horizontal and vertical count subtract the offset and then divide by 8 in order to get an index to the screen data
                    if disp_data((to_integer(unsigned(hor_counter))-228)/8)((to_integer(unsigned(ver_counter))-100)/8) = '1' then
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
                    RED <= "1111";
                    GREEN <= "1111";
                    BLUE <= "1111";
                else
                    -- This is our "OFF" Pixel
                    RED <= "0000";
                    GREEN <= "0110";
                    BLUE <= "0111";
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