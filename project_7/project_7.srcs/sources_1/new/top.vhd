----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.06.2023 23:53:08
-- Design Name: 
-- Module Name: top - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port(  X1 : in STD_LOGIC := '1';
           X2 : in STD_LOGIC := '0';
           X3 : in STD_LOGIC := '0';
           clk : in STD_LOGIC;
           rst : in STD_LOGIC);
end top;

architecture Behavioral of top is
signal wipe_on : std_logic := '0';
signal home_pos : std_logic := '0';
signal end_pos : std_logic := '0';
signal motor_on : std_logic := '0';
signal motor_rev  : std_logic := '0';
begin
wipe_on <= X2;
home_pos <= X1;
end_pos <= X3;

wiper: process (clk, rst) is
begin
    if rst = '1' then
        if home_pos <= '1' then
            motor_on <= '0';
            motor_rev <= '0';
        else
            motor_on <= '1';
            motor_rev <= '1';
        end if;
    elsif rising_edge(clk) then
        if home_pos = '1' and wipe_on = '0' and end_pos = '0' then
            motor_on <= '0';
            motor_rev <= '0';
        elsif home_pos = '1' and wipe_on = '1' and end_pos = '0' then
            motor_on <= '1';
            motor_rev <= '0';
        elsif end_pos = '1' then
            motor_on <= '1';
            motor_rev <= '1';
        end if;
    end if;
    
end process;

end Behavioral;
