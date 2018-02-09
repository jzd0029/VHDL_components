----------------------------------------------------------------------------------
-- Company: Eikon Research
-- Engineer: Justin Dunaway
-- 
-- Create Date: 02/08/2018 03:05:27 PM
-- Design Name: Test Bench for designed components
-- Module Name: Debounce_TB - Behavioral
-- Project Name: CAL Training Program
-- Target Devices: XC7A100tcsg324-1
-- Tool Versions: 
-- Description: This design is a test bench for validating the operation 
--              of designed components in simulation, specifically for the
--              debounce module.
-- Dependencies: Debounce.vhd
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Run simulation for 250 ns to see functionality.
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

entity Debounce_TB is
--  Port ( );
end Debounce_TB;

architecture Behavioral of Debounce_TB is
signal tb_clk: std_logic := '0';
signal tb_db: std_logic := '0';
signal tb_pb: std_logic := '0';

component Debounce is
    generic ( N : integer := 8);
    port ( 	PB : in STD_LOGIC;		--Signal to debounce
			CLK : in STD_LOGIC;		--Clock
			PBdb : out STD_LOGIC := '0');	--debounced signal
end component Debounce;

begin

--MUT: Debounce generic map (3) port map (CLK=>tb_clk, PB=>tb_pb, PBdb=>tb_db);
MUT: Debounce generic map (3) port map (tb_pb, tb_clk, tb_db);
tb_clk<=not tb_clk after 5 ns; --generate clock signal
tb_pb<='1' after 5 ns, '0' after 5.5 ns, '1' after 6 ns, '0' after 20 ns , '1' after 21 ns, '0' after 21.5 ns, '1' after 25 ns, '0' after 125 ns,
        '1' after 125.5 ns, '0' after 126.2 ns, '1' after 127 ns, '0' after 128 ns;
end Behavioral;
