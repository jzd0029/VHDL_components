----------------------------------------------------------------------------------
-- Company: Eikon Research
-- Engineer: Justin Dunaway
-- 
-- Create Date: 02/09/2018 02:40:11 PM
-- Design Name: Test Bench for designed components
-- Module Name: Data_REG_TB - Behavioral
-- Project Name: CAL Training Program
-- Target Devices: XC7A100tcsg324-1
-- Tool Versions: 
-- Description: This design is a test bench for validating the operation 
--              of designed components in simulation, specifically for the
--              data register used in the SPI design.
-- Dependencies: Data_REG.vhd
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Run simulation for 2.66 us to see functionality.
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

entity Data_REG_TB is
--  Port ( );
end Data_REG_TB;

architecture Behavioral of Data_REG_TB is
constant B:integer := 8;
signal tb_clk: std_logic := '0';
signal tb_en: std_logic := '1';
signal TB_DI,TB_DO: std_logic_vector(B-1 downto 0);

component Data_REG is
    generic (N: integer := 6); -- N specified when REG used
    port(CLK,EN: in std_logic;
                DIN: in std_logic_vector (N-1 downto 0); -- N-bit data in
                Q: out std_logic_vector (N-1 downto 0):=(others => '0'));  -- N-bit Q out
end component Data_REG;

begin

--RegTest: Data_REG generic map (8) port map (CLK=>tb_clk, EN=>tb_en, DIN=>TB_DI, Q=>TB_DO);
RegTest: Data_REG generic map (8) port map (tb_clk, tb_en, TB_DI, TB_DO);
tb_clk<=not tb_clk after 5 ns; --generate clock signal
tb_en<='0' after 2560 ns, '1' after 2585 ns; --enable on
process begin
for m in 0 to 255 loop -- 256 writable values
    TB_DI <= std_logic_vector(to_UNSIGNED(m,8)); -- apply m to DataIn
        wait for 10 ns; -- allow time clock transition
        assert (to_integer(UNSIGNED(TB_DO)) = (m)) -- expected output
        report "Incorrect Write"
        severity NOTE;
end loop;
report "Test Complete";
end process;
end behavioral;
