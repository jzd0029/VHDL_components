----------------------------------------------------------------------------------
-- Company: Eikon Research
-- Engineer: Justin Dunaway
-- 
-- Create Date: 02/08/2018 03:05:27 PM
-- Design Name: Basic Shift Register
-- Module Name: SR - RTL
-- Project Name: CAL Training Program
-- Target Devices: XC7A100tcsg324-1
-- Tool Versions: 
-- Description: This design is a shift register. It was specifically created
--              for the SPI to picoblaze interface to receive serial data inputs, 
--              but can be used/modified for other applications.  
-- Dependencies: none
-- 
-- Revision: 1.00 - Completed w/ correct simulation, no timing
-- Revision 0.01 - File Created
-- Additional Comments: Change the size of N to change SR data size. 
--                      #Bits = N-1
--                      Bits shift in through N-1 bit and out through bit 0                
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Shift_REG is
	generic (N: integer := 6); -- N specified when REG used
	port ( 	CLK: in std_logic;
			DIN: in std_logic; -- data in
			Q: out std_logic_vector (N-1 downto 0):=(others => '0'));  -- N-bit Q out
end Shift_REG;

architecture RTL of Shift_REG is
	signal Qold: std_logic_vector (N-1 downto 0):=(others => '0');  

begin
	Q <= Qold;
	P1: process (CLK) --sets the sensitivity to clock change
	begin
		if rising_edge(CLK) then
			Qold <= DIN & Qold(N-1 downto 1); --right shift output
		end if;
	end process;

end RTL;
