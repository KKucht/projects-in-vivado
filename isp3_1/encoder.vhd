----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2023 08:22:18 AM
-- Design Name: 
-- Module Name: encoder - Behavioral
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity encoder is
    Port ( clk_i : in STD_LOGIC;
           btn_i : in STD_LOGIC_VECTOR (3 downto 0);
           sw_i : in STD_LOGIC_VECTOR (7 downto 0);
           digit_i : out STD_LOGIC_VECTOR (31 downto 0) := "11111111111111111111111111111111");
end encoder;

architecture Behavioral of encoder is
signal number : integer := 0;
signal image : STD_LOGIC_VECTOR (6 downto 0) := "1111111";
begin

   number <= to_integer(unsigned(sw_i(3 downto 0)));
   
   image <= "0000001" when (number = 0) else
            "1001111" when (number = 1) else
            "0010010" when (number = 2) else
            "0000110" when (number = 3) else
            "1001100" when (number = 4) else
            "0100100" when (number = 5) else
            "0100000" when (number = 6) else
            "0001111" when (number = 7) else
            "0000000" when (number = 8) else
            "0000100" when (number = 9) else
            "0001000" when (number = 10) else
            "1100000" when (number = 11) else
            "0110001" when (number = 12) else
            "1000010" when (number = 13) else
            "0110000" when (number = 14) else
            "0001110" when (number = 15);

digit_i(0) <= not sw_i(7);
digit_i(8) <= not sw_i(6);
digit_i(16) <= not sw_i(5);
digit_i(24) <= not sw_i(4);
            
--points: process(clk_i,sw_i) is 
--begin
--    if rising_edge(clk_i) then
--        if sw_i(7) = '1' then
--            digit_i(31) <= '0';
--        else
--            digit_i(31) <= '1';
--        end if;
--        if sw_i(6) = '1' then
--            digit_i(23) <= '0';
--        else
--            digit_i(23) <= '1';
--        end if;
--        if sw_i(5) = '1' then
--            digit_i(15) <= '0';
--        else
--            digit_i(15) <= '1';
--        end if;
--        if sw_i(4) = '1' then
--            digit_i(7) <= '0';
--        else
--            digit_i(7) <= '1';
--        end if;
--    end if;
--end process points;  

encoding: process (clk_i, btn_i) is
begin
    if rising_edge(clk_i)  then
        if btn_i(3) = '1' then
            digit_i(7 downto 1) <= image;
        elsif btn_i(2) = '1'then
            digit_i(15 downto 9) <= image;
        elsif btn_i(1) = '1'then
            digit_i(23 downto 17) <= image;
        elsif btn_i(0) = '1'then
            digit_i(31 downto 25) <= image;
        end if;
    end if;
end process encoding;


end Behavioral;
