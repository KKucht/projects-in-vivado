----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2023 22:10:54
-- Design Name: 
-- Module Name: RDX_encoder - Behavioral
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

entity RDX_encoder is
    Port ( clk_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           RXD_i : in STD_LOGIC;
           digit_i : out STD_LOGIC_VECTOR (31 downto 0) := "11111111111111111111111111111111");
end RDX_encoder;

architecture Behavioral of RDX_encoder is


-- number of cicles of clock for one bit is 1 / 9600 seconds * 100 MHz (clock frequency)
-- so it is 10 416
signal time_counter : integer := 0;
signal number_of_bits : integer := 0;
signal transfer : std_logic := '0';

signal read_data : std_logic_vector (7 downto 0):= "00000000";

signal image1 : std_logic_vector (6 downto 0):= "1111111";
signal image2 : std_logic_vector (6 downto 0):= "1111111";

begin

image1 <= "0000001" when (read_data(7 downto 4) = "0000") else
          "1001111" when (read_data(7 downto 4) = "0001") else
          "0010010" when (read_data(7 downto 4) = "0010") else
          "0000110" when (read_data(7 downto 4) = "0011") else
          "1001100" when (read_data(7 downto 4) = "0100") else
          "0100100" when (read_data(7 downto 4) = "0101") else
          "0100000" when (read_data(7 downto 4) = "0110") else
          "0001111" when (read_data(7 downto 4) = "0111") else
          "0000000" when (read_data(7 downto 4) = "1000") else
          "0000100" when (read_data(7 downto 4) = "1001") else
          "0001000" when (read_data(7 downto 4) = "1010") else
          "1100000" when (read_data(7 downto 4) = "1011") else
          "0110001" when (read_data(7 downto 4) = "1100") else
          "1000010" when (read_data(7 downto 4) = "1101") else
          "0110000" when (read_data(7 downto 4) = "1110") else
          "0001110" when (read_data(7 downto 4) = "1111");
          
image2 <= "0000001" when (read_data(3 downto 0) = "0000") else
          "1001111" when (read_data(3 downto 0) = "0001") else
          "0010010" when (read_data(3 downto 0) = "0010") else
          "0000110" when (read_data(3 downto 0) = "0011") else
          "1001100" when (read_data(3 downto 0) = "0100") else
          "0100100" when (read_data(3 downto 0) = "0101") else
          "0100000" when (read_data(3 downto 0) = "0110") else
          "0001111" when (read_data(3 downto 0) = "0111") else
          "0000000" when (read_data(3 downto 0) = "1000") else
          "0000100" when (read_data(3 downto 0) = "1001") else
          "0001000" when (read_data(3 downto 0) = "1010") else
          "1100000" when (read_data(3 downto 0) = "1011") else
          "0110001" when (read_data(3 downto 0) = "1100") else
          "1000010" when (read_data(3 downto 0) = "1101") else
          "0110000" when (read_data(3 downto 0) = "1110") else
          "0001110" when (read_data(3 downto 0) = "1111");

encoding: process (clk_i, RXD_i, read_data) is
begin
    if rising_edge(clk_i) then
        if transfer = '0' then
            if RXD_i = '0' then
                transfer <= '1';
                time_counter <= 0;
                number_of_bits <= 0;
            end if;
        elsif number_of_bits = 0 then
            if time_counter = 5208 then
                if RXD_i = '1' then
                    transfer <= '0';
                else
                    time_counter <= 0;
                    number_of_bits <= 1;
                end if;
            else
                time_counter <= time_counter + 1;
            end if;
        elsif number_of_bits = 9 then
            transfer <= '0';
            time_counter <= 0;
            number_of_bits <= 0;
            digit_i(7 downto 1) <= image1;
            digit_i(15 downto 9) <= image2;
        else
            if time_counter = 10416 then
                time_counter <= 0;
                number_of_bits <= number_of_bits + 1;
                read_data(8 - number_of_bits) <= '0';
            else
                time_counter <= time_counter + 1;
            end if;
        end if;
    end if;
end process encoding;


end Behavioral;
