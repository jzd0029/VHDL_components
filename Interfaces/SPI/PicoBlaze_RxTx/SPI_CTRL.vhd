----------------------------------------------------------------------------------
-- Company: Eikon Research
-- Engineer: Justin Dunaway
-- 
-- Create Date: 02/08/2018 10:06:29 AM
-- Design Name: SPI controller for picoblaze interface
-- Module Name: SPI_CTRL - Behavioral
-- Project Name: CAL Training Program
-- Target Devices: XC7A100tcsg324-1
-- Tool Versions: 
-- Description: This design is a controller for the SPI interface to the picoblaze
--              processor. It counts the number of inputs using an external pushbutton,
--              input through SCK. The max number of inputs is set by the size of the
--              SR storing serial inputs, and the signal MXCNT. After the max count is
--              reached (6), it outputs a 1 clock cycle pulse on the EN and INTpulse outputs.
-- Dependencies: none
-- 
-- Revision: 1.00 - Completed w/ correct simulation, no timing
-- Revision 0.01 - File Created
-- Additional Comments: 6th and 7th SCK pulses should not inhabit back-to-back clk transitions
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SPI_CTRL is
	generic (N: integer := 3; --size of unsigned count value
	         MaxCnt: integer:= 6); -- max number of bits to input
	port ( 	CLK: in std_logic;
			SCK: in std_logic; -- transistions input for SR, count for data size
			INTpulse: out std_logic:='0';  -- interrupt pulse for picoblaze
			EN: out std_logic:='0');  -- enable for data register
end SPI_CTRL;

architecture Behavioral of SPI_CTRL is
	signal MXCNT: std_logic_vector (N-1 downto 0):=std_logic_vector(to_UNSIGNED(MaxCnt,N)); -- max count output is 6
	signal CNT: std_logic_vector (N-1 downto 0):=(others => '0'); -- count
	signal CNTzero: std_logic_vector (N-1 downto 0):=(others => '0'); -- count with all 0's for comparison

begin

	P1: process (CLK) --increments count
	begin
		if rising_edge(CLK) then
			if (SCK='1') then
			         CNT<= std_logic_vector(UNSIGNED(CNT)+1);
			end if;
			if (CNT=MXCNT) then
                     CNT<=(others => '0');
                     EN <= '1';
                     INTpulse <= '1';
            elsif (CNT=CNTzero) then
                     EN <= '0';
                     INTpulse <= '0';
			end if;
		end if;
	end process;
	
end Behavioral;
