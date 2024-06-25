----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.06.2023 13:50:40
-- Design Name: 
-- Module Name: top_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
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

entity top_tb is
--  Port ( );
end top_tb;



architecture Behavioral of top_tb is

component top is
    Port(  X1 : in STD_LOGIC := '1';
           X2 : in STD_LOGIC := '0';
           X3 : in STD_LOGIC := '0';
           clk : in STD_LOGIC;
           rst : in STD_LOGIC);
end component top;


signal X1 : std_logic := '1';
signal X2 : std_logic := '0';
signal X3 : std_logic := '0';
signal clk : std_logic := '0';
signal rst : std_logic := '0';
begin
dut: top port map (
    X1 => X1,
    X2 => X2,
    X3 => X3,
    clk => clk,
    rst => rst
);

clk <= not clk after 1 ns;

strst: process
begin
    wait for 5000 ns;
        rst <= '1';
        wait for 50 ns;
end process;
end Behavioral;
