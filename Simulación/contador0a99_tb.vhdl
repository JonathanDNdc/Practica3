library ieee;
use ieee.std_logic_1164.all;

entity contador0a99_tb is
end contador0a99_tb;

architecture test of contador0a99_tb is
  component contador0a99 is
   generic(
      delay_com : time := 12 ps
    );
    port(
      Clk     : in  std_logic := '0';
      up_down : in  std_logic := '0';
      Q       : out std_logic_vector(7 downto 0)
    );
  end component;

  constant CLK_PERIOD : time := 10 ns;
  constant delay_com  : time := 12 ps;
  signal Clk_pulse    : std_logic := '0';

  signal Clk     : std_logic := '0';
  signal up_down : std_logic := '0';
  signal Q       : std_logic_vector(7 downto 0);
begin

  Clk <= not Clk after CLK_PERIOD / 2;


    uut : contador0a99 port map(Clk_pulse, up_down, Q);

  process(Clk)
  begin
    if (rising_edge(Clk)) then
      Clk_pulse <= '1', '0' after 2 * delay_com;
    end if;
  end process;

  process
  begin
    wait for 200 * CLK_PERIOD;
    up_down <= '1';
    wait;
  end process;

end test;