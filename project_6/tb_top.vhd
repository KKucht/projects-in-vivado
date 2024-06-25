----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2023 08:18:52 AM
-- Design Name: 
-- Module Name: tb_top - Behavioral
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

entity tb_top is
--  Port ( );
end tb_top;

architecture Behavioral of tb_top is

component top
    Port ( clk_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           RXD_i : in STD_LOGIC;
           led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal clk_i : STD_LOGIC := '1';
signal rst_i : STD_LOGIC := '0';
signal RXD_i : STD_LOGIC := '1';
signal led7_an_o : STD_LOGIC_VECTOR (3 downto 0);
signal led7_seg_o : STD_LOGIC_VECTOR (7 downto 0);

signal my_signal : STD_LOGIC_VECTOR (7 downto 0) := "01010001";
signal counter : integer := 0;

begin

clk_i <= not clk_i after 5 ns;

uut3: top port map(
    clk_i => clk_i,
    rst_i => rst_i,
    RXD_i => RXD_i,
    led7_an_o => led7_an_o,
    led7_seg_o => led7_seg_o
);


encoding: process is
begin
    wait for 104166 ns;
    RXD_i <= '0';
    for k in 0 to 7 loop
        wait for 104166 ns;
        RXD_i <= my_signal(7 - k);
    end loop;
    wait for 104166 ns;
    RXD_i <= '1';
end process encoding;


end Behavioral;
