----------------------------------------------------------------------------------
-- Company: Eikon Research
-- Engineer: Justin Dunaway
-- 
-- Create Date: 02/08/2018 03:05:27 PM
-- Design Name: Basic D FlipFlop
-- Module Name: D_FF - RTL
-- Project Name: CAL Training Program
-- Target Devices: XC7A100tcsg324-1
-- Tool Versions: 
-- Description: This design is a DFF. It was specifically created
--              for the SPI to picoblaze interface to pass the interrupt to the 
--              picoblaze, but can be used/modified for other applications.  
-- Dependencies: none
-- 
-- Revision: 1.00 - Completed w/ correct simulation, no timing
-- Revision 0.01 - File Created
-- Additional Comments: This component has a reset input labeled CLR for 
--                      initializing the FF output to '0'. CLR is active-high
--                      and synchronous.          
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_FF is
	port ( 	CLK: in std_logic;
			DIN,CLR: in std_logic; -- data in and clear
			Q: out std_logic:='0');  -- N-bit Q out
end D_FF;

architecture RTL of D_FF is 

begin
	P1: process (CLK) --sets the sensitivity to clock change
	begin
		if rising_edge(CLK) then
			if (CLR='1') then
				Q<='0';
			else
				Q <= DIN;
			end if;
		end if;
	end process;

end RTL;
