----------------------------------------------------------------------------------
-- Student: Justin Dunaway
-- 
-- Create Date: 11/05/2016 11:36:47 PM
-- Design Name: TOP level Lab#10, SPI receiver structure input to picoblaze
-- Module Name: PicoTOP - Behavioral
-- Project Name: Lab#10
-- Target Devices: XC7A100tcsg324-1
-- Tool Versions: 
-- Description: SPI/pico top model design
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity PicoTOP is
    Port (  MOSI,SCK : in std_logic;
			SEGout : out std_logic_vector(7 downto 0); --only uses first 7 bits
			SEGen : out std_logic_vector(7 downto 0); --only uses first 4 bits
            clk : in std_logic);
end PicoTOP;

architecture Behavioral of PicoTOP is
-- Declaration of the SPI receiver
	component TOP is 					-- counter, MSB used to change states of FSM
		generic (K: integer := 6); -- K declares size of serial data
	Port (		MOSI,SCK,INTack : in std_logic;
				clk : in std_logic;
				INT : out std_logic;
				DRout : out std_logic_vector(K-1 downto 0):=(others => '0'));
	end component;
-- Declaration of the register to hold outputs of picoblaze
	component REGN is 					-- counter, MSB used to change states of FSM
		generic (N: integer := 8); 										-- N specified when REG used
		port ( 
			CLK, EN, STB: in std_logic;
			DIN: in std_logic_vector (N-1 downto 0); 					-- N-bit data in
			Q: out std_logic_vector (N-1 downto 0):=(others => '0'));  	-- N-bit Q out
	end component;
--
-- Declaration of the KCPSM6 processor component
--
  component kcpsm6 
    generic(                 hwbuild : std_logic_vector(7 downto 0) := X"00";
                    interrupt_vector : std_logic_vector(11 downto 0) := X"3FF";
             scratch_pad_memory_size : integer := 64);
    port (                   address : out std_logic_vector(11 downto 0);
                         instruction : in std_logic_vector(17 downto 0);
                         bram_enable : out std_logic;
                             in_port : in std_logic_vector(7 downto 0);
                            out_port : out std_logic_vector(7 downto 0);
                             port_id : out std_logic_vector(7 downto 0);
                        write_strobe : out std_logic;
                      k_write_strobe : out std_logic;
                         read_strobe : out std_logic;
                           interrupt : in std_logic;
                       interrupt_ack : out std_logic;
                               sleep : in std_logic;
                               reset : in std_logic;
                                 clk : in std_logic);
  end component;

--
-- Declaration of the default Program Memory recommended for development.
--
-- The name of this component should match the name of your PSM file.
--
component INT                            
    Port (      address : in std_logic_vector(11 downto 0);
            instruction : out std_logic_vector(17 downto 0);
                 enable : in std_logic;
                    clk : in std_logic);
  end component;

signal         address : std_logic_vector(11 downto 0);
signal     instruction : std_logic_vector(17 downto 0);
signal     bram_enable : std_logic;
signal         in_port : std_logic_vector(7 downto 0);
signal        out_port : std_logic_vector(7 downto 0);
signal         port_id : std_logic_vector(7 downto 0);
signal    write_strobe : std_logic;
signal  k_write_strobe : std_logic;
signal     read_strobe : std_logic;
signal       interrupt : std_logic;
signal   interrupt_ack : std_logic;
signal    kcpsm6_sleep : std_logic;
signal    kcpsm6_reset : std_logic;


begin
  -- Instantiating the register to hold output1 (7-segment output)
  -- loads and holds when portid is 01 and write strobe pulse
	OUT1: REGN generic map (8) port map (clk, port_id(0), write_strobe, out_port, SEGout);
  -- Instantiating the register to hold output2 (7-segment enable)
  -- loads and holds when portid is 02 and write strobe pulse
	OUT2: REGN generic map (8) port map (clk, port_id(1), write_strobe, out_port, SEGen);
  -- Instantiating the SPI
	SPI: TOP generic map (6) port map (MOSI, SCK, interrupt_ack, clk, interrupt, in_port(5 downto 0));
  -- Instantiating the PicoBlaze core
  processor: kcpsm6
    generic map (                 hwbuild => X"00", 
                         interrupt_vector => X"3FF",
                  scratch_pad_memory_size => 64)
    port map(      address => address,
               instruction => instruction,
               bram_enable => bram_enable,
                   port_id => port_id,
              write_strobe => write_strobe,
            k_write_strobe => k_write_strobe,
                  out_port => out_port,
               read_strobe => read_strobe,
                   in_port => in_port,
                 interrupt => interrupt,
             interrupt_ack => interrupt_ack,
                     sleep => kcpsm6_sleep,
                     reset => kcpsm6_reset,
                       clk => clk);
 
  --
  -- In many designs (especially your first) reset, interrupt and sleep are not used.
  -- Tie these inputs Low until you need them. Tying 'interrupt' to 'interrupt_ack' 
  -- preserves both signals for future use and avoids a warning message.
  -- 
  kcpsm6_reset <= '0';
  kcpsm6_sleep <= '0';

  -- Instantiating the program ROM
  program_rom: INT                    --Name to match your PSM file
    port map(      address => address,      
               instruction => instruction,
                    enable => bram_enable,
                       clk => clk);

   -- Connect I/O of PicoBlaze
   --connections made through component instantiations
  

 end Behavioral;
