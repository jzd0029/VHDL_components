----------------------------------------------------------------------------------
-- Company: Eikon Research
-- Engineer: Justin Dunaway
-- 
-- Create Date: 02/09/2018 01:17:56 PM
-- Design Name: Test Bench for designed components
-- Module Name: D_FF_TB - Behavioral
-- Project Name: CAL Training Program
-- Target Devices: XC7A100tcsg324-1
-- Tool Versions: 
-- Description: This design is a test bench for validating the operation 
--              of designed components in simulation, specifically for the
--              D flip flop module.
-- Dependencies: D_FF.vhd
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

entity D_FF_TB is
--  Port ( );
end D_FF_TB;

architecture Behavioral of D_FF_TB is
constant N:integer := 8;
signal tb_clk: std_logic := '0';
signal tb_in: std_logic := '1';
signal tb_q: std_logic;
signal tb_clr: std_logic := '0';

component D_FF is
    port ( 	CLK: in std_logic;
			DIN,CLR: in std_logic; -- data in and clear
			Q: out std_logic:='0');  -- N-bit Q out
end component D_FF;

begin

MUT: D_FF port map (CLK=>tb_clk, DIN=>tb_in, Q=>tb_q, CLR=>tb_clr);
--MUT: Shift_REG generic map (8) port map (tb_clk, tb_in, tb_clr, tb_q);
tb_clk<=not tb_clk after 5 ns; --generate clock signal
tb_in<=not tb_in after 20 ns;
tb_clr<='1' after 10 ns, '0' after 20 ns;
end Behavioral;
