----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2023 08:20:09 AM
-- Design Name: 
-- Module Name: display - Behavioral
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

entity display is
    Port ( clk_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           digit_i : in STD_LOGIC_VECTOR (31 downto 0);
           led7_an_o : out STD_LOGIC_VECTOR (3 downto 0) := "1111";
           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0):= "11111111") ;
end display;

architecture Behavioral of display is

signal my_clk : std_logic := '0';
signal max_counter : integer := 50000;
signal counter : integer := 0;
signal nr_block : integer := 0;

begin

display_numbers: process (my_clk) is
begin
    if rising_edge(my_clk)  then
        if nr_block = 3 then 
            nr_block <= 0;
        else
            nr_block <= nr_block + 1; 
        end if;
        if nr_block = 0 then
            led7_seg_o <= digit_i(7 downto 0);
            led7_an_o <= "0111";
        elsif nr_block = 1 then
            led7_seg_o <= digit_i(15 downto 8);
            led7_an_o <= "1011";
        elsif nr_block = 2 then
            led7_seg_o <= digit_i(23 downto 16);
            led7_an_o <= "1101";
        elsif nr_block = 3 then
            led7_seg_o <= digit_i(31 downto 24);
            led7_an_o <= "1110";
        end if;
    end if;
end process display_numbers;

cl_my_clk: process (clk_i, my_clk) is
begin
    if rising_edge(clk_i)  then
        counter <= counter + 1;
        if counter = max_counter then
            counter <= 0;
            if my_clk = '0' then
                my_clk <= '1';
            else
                my_clk <= '0';
            end if;
        end if;
    end if;
end process cl_my_clk;
end Behavioral;
