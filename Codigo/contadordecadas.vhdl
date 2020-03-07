library ieee;
use ieee.std_logic_1164.all;

entity contadordecadas is
  generic(
    delay_com : time := 7 ps
  );
  port(
    Clk     : in  std_logic := '0';
    up_down : in  std_logic := '0';
    Q       : out std_logic_vector(3 downto 0)
  );
end contadordecadas;

architecture structure of contadordecadas is
  component contador4bits is
    generic(
      delay_com : time := 3 ps
    );
    port(
      Clk     : in  std_logic                    := '0';
      up_down : in  std_logic                    := '0';
      Clear   : in  std_logic_vector(3 downto 0) := "0000";
      Q       : out std_logic_vector(3 downto 0)
    );
  end component;
  signal Clear : std_logic_vector(3 downto 0) := "0000";
  signal Qi    : std_logic_vector(3 downto 0) := "0000";
  signal nQi   : std_logic_vector(3 downto 0) := "1111";

begin
    c4b : contador4bits port map (Clk, up_down, Clear, Qi);

  Clear(1) <= Qi(1) nand Qi(3) after delay_com;
  Clear(2) <= Qi(1) nand Qi(3) after delay_com;
  Clear(3) <= Clear(1) or up_down after delay_com; -- Equivalente not Clear(1) nand not up_down
  Clear(0) <= Clear(1) or up_down after delay_com;
  Q        <= Qi;

end structure;