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
--              SPI controller module.
-- Dependencies: SPI_CTRL.vhd
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Run simulation for 140 ns to see functionality.
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

entity SPI_CTRL_TB is
--  Port ( );
end SPI_CTRL_TB;

architecture Behavioral of SPI_CTRL_TB is

signal tb_clk: std_logic := '0';
signal tb_sck: std_logic := '0';
signal tb_en, tb_int: std_logic;

component SPI_CTRL is
    port ( 	CLK: in std_logic;
			SCK: in std_logic; -- transistions input for SR, count for data size
			INTpulse: out std_logic:='0';  -- interrupt pulse for picoblaze
			EN: out std_logic:='0');  -- enable for data register
end component SPI_CTRL;

begin

--RegTest: Syn_REG generic map (8) port map (CLK=>tb_clk, SCK=>tb_sck, INTpulse=>tb_int, EN=>tb_en);
MUT: SPI_CTRL port map (tb_clk, tb_sck, tb_int, tb_en);
tb_clk<=not tb_clk after 5 ns; --generate clock signal
tb_sck<=not tb_sck after 60 ns;

end Behavioral;
