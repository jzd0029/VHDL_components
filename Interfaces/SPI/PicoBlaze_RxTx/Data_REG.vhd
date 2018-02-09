----------------------------------------------------------------------------------
-- Company: Eikon Research
-- Engineer: Justin Dunaway
-- 
-- Create Date: 02/09/2018 02:29:35 PM
-- Design Name: Data Register w/ Enable
-- Module Name: Data_REG - Behavioral
-- Project Name: CAL Training Program
-- Target Devices: XC7A100tcsg324-1
-- Tool Versions: 
-- Description: This design is a data register with an enable for loading data. 
--              It was specifically created for the SPI to picoblaze interface, 
--              where it captures data passed by the shift register.
--              
-- Dependencies: none
-- 
-- Revision: 1.00 - Completed w/ correct simulation, no timing
-- Revision 0.01 - File Created
-- Additional Comments: Enable is active-high. 
--                      
--   
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Data_REG is
	generic (N: integer := 6); -- N specified when REG used
	port ( 	CLK,EN: in std_logic;
			DIN: in std_logic_vector (N-1 downto 0); -- N-bit data in
			Q: out std_logic_vector (N-1 downto 0):=(others => '0'));  -- N-bit Q out
end Data_REG;

architecture Behavioral of Data_REG is

begin

	P1: process (CLK) --sets the sensitivity to clock change
	begin
		if rising_edge(CLK) then
			if (EN = '1') then
				Q <= DIN; --load output
			end if;
		end if;
	end process;

end Behavioral;
