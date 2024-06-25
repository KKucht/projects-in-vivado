----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.04.2023 19:44:23
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
use ieee.numeric_std.all;

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

component top is
    Port ( clk_i : in STD_LOGIC;
           btn_i : in STD_LOGIC_VECTOR (3 downto 0);
           sw_i : in STD_LOGIC_VECTOR (7 downto 0);
           led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end component top;

signal clk_i : STD_LOGIC := '0';
signal btn_i : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal sw_i : STD_LOGIC_VECTOR (7 downto 0)  := "00000000";
signal led7_an_o : STD_LOGIC_VECTOR (3 downto 0);
signal led7_seg_o : STD_LOGIC_VECTOR (7 downto 0);

signal button : integer := 0;
signal number : integer := 0;
signal points : integer := 3;
begin

dut: top port map (
    clk_i => clk_i,
    btn_i => btn_i,
    sw_i => sw_i,
    led7_an_o => led7_an_o,
    led7_seg_o => led7_seg_o
);

clk_i <= not clk_i after 1 ns;

stim: process
begin
    wait for 1000 ns;
        if button = 3 then
            button <= 0;
        else
            button <= button + 1;    
        end if;
        if button = 0 then
            btn_i <= "0001";
        elsif button = 1 then
            btn_i <= "0010";
        elsif button = 2 then
            btn_i <= "0100";
        elsif button = 3 then
            btn_i <= "1000";
        end if;
    wait for 1000 ns;
        btn_i <= "0000";
    wait for 1000 ns;
        if number = 15 then
            number <= 0;
        else
            number <= number + 1;    
        end if;  
        if points = 3 then
            points <= 0;
        else
            points <= points + 1;    
        end if;
        sw_i(3 downto 0) <= std_logic_vector(to_unsigned(number, 4));
        if points = 0 then
            if sw_i(4) = '1' then
                sw_i(4) <= '0';
            else
                sw_i(4) <= '1';
            end if;
         elsif points = 1 then
            if sw_i(5) = '1' then
                sw_i(5) <= '0';
            else
                sw_i(5) <= '1';
            end if;
         elsif points = 2 then
            if sw_i(6) = '1' then
                sw_i(6) <= '0';
            else
                sw_i(6) <= '1';
            end if;
         elsif points = 3 then
            if sw_i(7) = '1' then
                sw_i(7) <= '0';
            else
                sw_i(7) <= '1';
            end if;
         end if;
end process;

end Behavioral;
