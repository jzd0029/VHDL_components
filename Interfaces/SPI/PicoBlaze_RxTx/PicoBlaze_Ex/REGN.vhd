----------------------------------------------------------------------------------
-- Student: Justin Dunaway
-- 
-- Create Date: 10/30/2016 11:36:47 PM
-- Design Name: N-bit universal register
-- Module Name: REGN - RTL
-- Project Name: Lab#9
-- Target Devices: XC7A100tcsg324-1
-- Tool Versions: 
-- Description: N sized register with 2 enables 
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity REGN is
generic (N: integer := 8); -- N specified when REG used
port ( CLK, EN, STB: in std_logic;
DIN: in std_logic_vector (N-1 downto 0); -- N-bit data in
Q: out std_logic_vector (N-1 downto 0):=(others => '0'));  -- N-bit Q out
end REGN;

architecture RTL of REGN is

begin

P1: process (CLK) --sets the sensitivity to clock change
begin
	if rising_edge(CLK) then
		if (EN = '1') then 
			if (STB = '1') then
				Q<=DIN;
			end if;
		end if;
	end if;
end process;

end RTL;
