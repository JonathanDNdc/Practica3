library ieee;
use ieee.std_logic_1164.all;

entity JKFlipFlop_tb is
end JKFlipFlop_tb;

architecture test of JKFlipFlop_tb is
  component JKFlipFlop is
    generic(
      delay_com : time := 1 ps
    );
    port(
      J, K   : in  std_logic := '0';
      Clk    : in  std_logic := '0';
      Preset : in  std_logic := '1';
      Clear  : in  std_logic := '0';
      Q      : out std_logic := '0';
      notQ   : out std_logic := '1');
  end component;

  constant CLK_PERIOD : time      := 10 ns;
  constant delay_com  : time      := 1 ps;
  signal Clk_pulse    : std_logic := '0';

  signal J      : std_logic := '0';
  signal K      : std_logic := '0';
  signal Clk    : std_logic := '0';
  signal Preset : std_logic := '1';
  signal Clear  : std_logic := '0';
  signal Q      : std_logic := '0';
  signal notQ   : std_logic := '1';
begin

  Clk <= not Clk after CLK_PERIOD / 2;


  uut : JKFlipFlop
    generic map(delay_com)
    port map(J, K, Clk_pulse, Preset, Clear, Q, notQ);

  process(Clk)
  begin
    if (rising_edge(Clk)) then
      Clk_pulse <= '1', '0' after 2 * delay_com;
    end if;
  end process;

  process
  begin
    wait for CLK_PERIOD;
    Clear <= '1';
    J     <= '0';
    K     <= '1';
    wait for CLK_PERIOD;
    J <= '1';
    K <= '0';
    wait for CLK_PERIOD;
    J <= '1';
    K <= '1';
    wait for CLK_PERIOD;
    J <= '0';
    K <= '0';
    wait for CLK_PERIOD;
    J <= '0';
    K <= '1';
    wait for CLK_PERIOD;
    J <= '1';
    K <= '0';
    wait for CLK_PERIOD;
    J <= '1';
    K <= '1';
    wait;
  end process;

end test;