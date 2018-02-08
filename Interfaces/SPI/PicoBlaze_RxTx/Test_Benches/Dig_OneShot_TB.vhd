----------------------------------------------------------------------------------
-- Company: Eikon Research
-- Engineer: Justin Dunaway
-- 
-- Create Date: 02/08/2018 02:28:50 PM
-- Design Name: Test Bench for designed components
-- Module Name: Dig_OneShot_TB - Behavioral
-- Project Name: CAL Training Program
-- Target Devices: XC7A100tcsg324-1
-- Tool Versions: 
-- Description: This design is a test bench for validating the operation 
--              of designed components in simulation, specifically for the
--              digital one-shot module.
-- Dependencies: Dig_OneShot.vhd
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Run simulation for 100 ns to see functionality.
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Dig_OneShot_TB is
--  Port ( );
end Dig_OneShot_TB;

architecture Behavioral of Dig_OneShot_TB is
signal tb_clk: std_logic := '0';
signal tb_en: std_logic := '0';
signal tb_pb: std_logic := '0';

component Dig_OneShot is
    port ( 	PB : in STD_LOGIC;		--input from debounced output
			EN : out STD_LOGIC;     --one-shot output
			CLK : in STD_LOGIC);		--Clock
end component Dig_OneShot;

begin

--RegTest: Dig_OneShot generic map (8) port map (CLK=>tb_clk, SCK=>tb_sck, INTpulse=>tb_int, EN=>tb_en);
MUT: Dig_OneShot port map (tb_pb, tb_en, tb_clk);
tb_clk<=not tb_clk after 5 ns; --generate clock signal
tb_pb<='1' after 30 ns, '0' after 90 ns;
end Behavioral;
