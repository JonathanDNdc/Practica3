library ieee;
use ieee.std_logic_1164.all;

entity JKFlipFlop is
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
end JKFlipFlop;

architecture structure of JKFlipFlop is
    signal S1,S2,S3,S4 : std_logic;
begin
    S1   <= not (Clk and J and S4) after delay_com;
    S2   <= not (Clk and k and S3) after delay_com;
    S3   <= not (Preset and S1 and S4) after delay_com;
    S4   <= not (Clear and S2 and S3) after delay_com;
    Q    <= S3 after delay_com;
    notQ <= S4 after delay_com;
end structure;