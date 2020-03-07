library ieee;
use ieee.std_logic_1164.all;

entity contadordecadas_tb is
end contadordecadas_tb;

architecture test of contadordecadas_tb is
  component contadordecadas is
   generic(
      delay_com : time := 7 ps
    );
    port(
      Clk     : in  std_logic := '0';
      up_down : in  std_logic := '0';
      Q       : out std_logic_vector(3 downto 0)
    );
  end component;

  constant CLK_PERIOD : time := 10 ns;
  constant delay_com  : time := 7 ps;
  signal Clk_pulse    : std_logic := '0';

  signal Clk     : std_logic := '0';
  signal up_down : std_logic := '0';
  signal Q       : std_logic_vector(3 downto 0);
begin

  Clk <= not Clk after CLK_PERIOD / 2;


    uut : contadordecadas port map(Clk_pulse, up_down, Q);

  process(Clk)
  begin
    if (rising_edge(Clk)) then
      Clk_pulse <= '1', '0' after 2 * delay_com;
    end if;
  end process;

  process
  begin
    wait for 20 * CLK_PERIOD;
    up_down <= '1';
    wait;
  end process;

end test;