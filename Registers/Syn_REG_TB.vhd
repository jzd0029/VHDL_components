----------------------------------------------------------------------------------
-- Company: Eikon Research
-- Engineer: Justin Dunaway
-- 
-- Create Date: 02/07/2018 09:35:31 AM
-- Design Name: Test Bench for designed components
-- Module Name: Test_Bench - Behavioral
-- Project Name: CAL Training Program
-- Target Devices: XC7A100tcsg324-1
-- Tool Versions: 
-- Description: This design is a test bench for validating the operation 
--              of designed components in simulation, specifically for the
--              synchronous reset register
-- Dependencies: Syn_REG.vhd
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Run simulation for 2.66 us to see functionality.
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.TEXTIO.all; -- calls package with routines for reading/writing files

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Syn_REG_TB is
--  Port ( );
end Syn_REG_TB;

architecture Behavioral of Syn_REG_TB is

constant B:integer := 8;
constant T:integer := 5; --half of a clock period in ns
signal tb_clk: std_logic := '0';
signal tb_rst: std_logic := '1';
signal tb_en: std_logic := '1';
signal TB_DI,TB_DO: std_logic_vector(B-1 downto 0);

component Syn_REG is
    generic (N: integer := 8); -- N specified when REG used
    port(CLK, RST, EN: in std_logic; 
         DataIn:in std_logic_vector (N-1 downto 0); -- N-bit data in
         DataOut:out std_logic_vector (N-1 downto 0):=(others => '0'));
end component Syn_REG;

begin

--RegTest: Syn_REG generic map (8) port map (CLK=>tb_clk, RST=>tb_rst, EN=>tb_en, DataIn=>TB_DI, DataOut=>TB_DO);
RegTest: Syn_REG generic map (8) port map (tb_clk, tb_rst, tb_en, TB_DI, TB_DO);
tb_clk<=not tb_clk after 5 ns; --generate clock signal
tb_rst<='0' after 2580 ns, '1' after 2582 ns;
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

end Behavioral;
