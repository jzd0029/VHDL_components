----------------------------------------------------------------------------------
-- Company: Eikon Research
-- Engineer: Justin Dunaway
-- 
-- Create Date: 02/07/2018 09:35:31 AM
-- Design Name: N-bit Asynchronous Reset Register w/ Enable
-- Module Name: AsynRST_REG - Behavioral
-- Project Name: CAL Training Program
-- Target Devices: XC7A100tcsg324-1
-- Tool Versions: 
-- Description: This design is an N-bit Register with an asynchronous active-low 
--              reset and an active-high enable input for loading data.
--  
-- Dependencies: none
-- 
-- Revision: 1.00 - Completed w/ correct simulation, no timing
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity AsynRST_REG is
generic (N: integer := 8); -- N specified when REG used
    Port ( CLK, RST, EN: in std_logic; 
           DataIn: in std_logic_vector (N-1 downto 0); -- N-bit data in
           DataOut: out std_logic_vector (N-1 downto 0):=(others => '0')
           );
end AsynRST_REG;

architecture Behavioral of AsynRST_REG is

begin
P1: process (CLK, RST) --sets the sensitivity to clock change and reset
begin
	if (RST = '0') then --asynchronous active low reset
			DataOut <= (others => '0'); --reset to all 0s
	elsif rising_edge(CLK) then
		if (EN = '1') then --synchronous enable to load input
		    Dataout <= DataIn;
		else -- else do nothing
		end if;
	end if;
end process;

end Behavioral;
