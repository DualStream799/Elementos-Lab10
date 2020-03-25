library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity controlunit is
	port (
			op:  in std_logic_vector(3 downto 0);
			ula: out std_logic_vector(5 downto 0)
	);
end entity;

architecture  rtl of controlunit is

begin

  with op select ula <=
  -- 6 bits = [zx, nx, zy, ny, f, no] e REG_C = X
  	"001100" when "0000", -- nop     => ULA_out = X
    "101010" when "0001", -- mov 0,C => ULA_out = 0
    "001101" when "1000", -- not C   => ULA_out = !X = not X
    "011111" when "1001", -- add 1,C => ULA_out = X + 1
    "000010" when "1010", -- add Y,C => ULA_out = X + Y
    "001110" when "1011", -- sub 1,C => ULA_out = X - 1
    "001100" when others;
end architecture;
