----------------------------------------------------------------------------------
-- Company: Eikon Research
-- Engineer: Justin Dunaway
-- 
-- Create Date: 02/09/2018 11:25:02 AM
-- Design Name: Test Bench for designed components
-- Module Name: Shift_REG_TB - Behavioral
-- Project Name: CAL Training Program
-- Target Devices: XC7A100tcsg324-1
-- Tool Versions: 
-- Description: This design is a test bench for validating the operation 
--              of designed components in simulation, specifically for the
--              shift register module.
-- Dependencies: Shift_REG.vhd
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Run simulation for 180 ns to see functionality.
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

entity Shift_REG_TB is
--  Port ( );
end Shift_REG_TB;

architecture Behavioral of Shift_REG_TB is
constant N:integer := 8;
signal tb_clk: std_logic := '0';
signal tb_in: std_logic := '1';
signal tb_q: std_logic_vector (N-1 downto 0):=(others => '0');

component Shift_REG is
    generic ( N : integer := 6);
    port ( 	CLK: in std_logic;
            DIN: in std_logic; -- data in
            Q: out std_logic_vector (N-1 downto 0):=(others => '0'));  -- N-bit Q out
end component Shift_REG;

begin

MUT: Shift_REG generic map (8) port map (CLK=>tb_clk, DIN=>tb_in, Q=>tb_q);
--MUT: Shift_REG generic map (8) port map (tb_clk, tb_in, tb_q);
tb_clk<=not tb_clk after 5 ns; --generate clock signal
tb_in<='0' after 90 ns;
end Behavioral;
