library ieee;
use ieee.std_logic_1164.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_topLevel is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_topLevel is

component TopLevel is
      port(
        USER_IN  : in  std_logic_vector(15 downto 0);
        USER_OUT : out std_logic_vector(15 downto 0);
        clk      : in  std_logic
        );
end component;

signal clk: std_logic := '0';
signal i,o : std_logic_vector(15 downto 0) := (others => '0');

begin

  clk <= not clk after 100 ps;

  u1 : toplevel port map (i, o, clk);

  main : process
    begin
      test_runner_setup(runner, runner_cfg);

      i <= x"AA01";

      wait until clk'event and clk='0';
      assert(o = x"0001")  report "Falha" severity error;

      wait until clk'event and clk='0';
      assert(o = x"0001")  report "Falha" severity error;

      -------------------------

      wait until clk'event and clk='0';
      assert(o = x"AA02")  report "Falha" severity error;

      wait until clk'event and clk='0';
      assert(o = x"AA01")  report "Falha" severity error;

      wait until clk'event and clk='0';
      assert(o = x"55FE")  report "Falha" severity error;

      test_runner_cleanup(runner); -- Simulation ends here

      wait;
      end process;
end architecture;
