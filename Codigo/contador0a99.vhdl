library ieee;
use ieee.std_logic_1164.all;

entity contador0a99 is
  generic(
    delay_com : time := 12 ps
  );
  port(
    Clk     : in  std_logic := '0';
    up_down : in  std_logic := '0';
    Q       : out std_logic_vector(7 downto 0)
  );
end contador0a99;

architecture structure of contador0a99 is
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
  signal Qi    : std_logic_vector(3 downto 0) := "0000";
  signal clkx : std_logic := '0';

begin
  clkx <= up_down xnor Qi(3) after delay_com;
    cdd0 : contadordecadas port map (Clk, up_down, Qi(3 downto 0));
    cdd1 : contadordecadas port map (Clk, up_down, Q(7 downto 4));
    Q(3 downto 0) <= Qi;

end structure;