----------------------------------------------------------------------------------
-- Company: Eikon Research
-- Engineer: Justin Dunaway
-- 
-- Create Date: 02/08/2018 10:08:21 AM
-- Design Name: Digital One-Shot for pushbutton inputs
-- Module Name: Dig_OneShot - Behavioral
-- Project Name: CAL Training Program
-- Target Devices: XC7A100tcsg324-1
-- Tool Versions: 
-- Description: This design is a digital one-shot for reading pushbutton inputs
--              and converting them to the length of one clock cycle. It was 
--              specifically designed for the SPI to picoblaze interface, but can 
--              be used to interface the pushbutton to any design, where an input
--              pulse length of one clock cycle is desired.
-- Dependencies: none
-- 
-- Revision: 1.00 - Completed w/ correct simulation, no timing
-- Revision 0.01 - File Created
-- Additional Comments: Input pulse should occupy at least one falling transition
--                      of the clock.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Dig_OneShot is
	Port (
			PB : in STD_LOGIC;		--input to debounce
			EN : out STD_LOGIC;     --debounced output
			CLK : in STD_LOGIC);		--Clock
end Dig_OneShot;

architecture Behavioral of Dig_OneShot is
	signal x,y,z: std_logic :='0';	--Internal flipflops
begin
	
	oneshot: process(CLK)
		begin
		if(falling_edge(CLK)) then		--On Rising Edge
			x<=PB; --push button to first FF
			y<=x;	--Pass first flip-flop to second
			z<=y;  --pass second FF to third
				
		end if;
	end process oneshot;
	EN<= y and not z;
end Behavioral;
