library ieee;
use ieee.std_logic_1164.all;

entity contador4bits is
  generic(
    delay_com : time := 3 ps
  );
  port(
    Clk     : in  std_logic := '0';
    up_down : in  std_logic := '0';
    Clear   : in  std_logic_vector(3 downto 0) := "0000";
    Q       : out std_logic_vector(3 downto 0)
  );
end contador4bits;

architecture structure of contador4bits is
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

  signal Qi   : std_logic_vector(3 downto 0);
  signal nQi  : std_logic_vector(3 downto 0);
  signal and1 : std_logic_vector(2 downto 0);
  signal and2 : std_logic_vector(2 downto 0);
  signal or1  : std_logic_vector(2 downto 0);

begin
  and1(0) <= not up_down and Qi(0) after delay_com;
  and2(0) <= up_down and nQi(0) after delay_com;
  or1(0)  <= and1(0) or and2(0) after delay_com;

  and1(1) <= and1(0) and Qi(1) after delay_com;
  and2(1) <= and2(0) and nQi(1) after delay_com;
  or1(1)  <= and1(1) or and2(1) after delay_com;

  and1(2) <= and1(1) and Qi(2) after delay_com;
  and2(2) <= and2(1) and nQi(2) after delay_com;
  or1(2)  <= and1(2) or and2(2) after delay_com;

    ff0 : JKFlipFlop port map ('1', '1', Clk, '1', Clear(0), Qi(0), nQi(0));
    ff1 : JKFlipFlop port map (or1(0), or1(0), Clk, '1', Clear(1), Qi(1), nQi(1));
    ff2 : JKFlipFlop port map (or1(1), or1(1), Clk, '1', Clear(2), Qi(2), nQi(2));
    ff3 : JKFlipFlop port map (or1(2), or1(2), Clk, '1', Clear(3), Qi(3), nQi(3));

  Q <= Qi after delay_com;
end structure;