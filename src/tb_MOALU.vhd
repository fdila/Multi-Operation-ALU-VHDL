library ieee;
use ieee.std_logic_1164.all;
 
entity tb_MOALU is
end tb_MOALU;
    
architecture tb_MOALU_behavior of tb_MOALU is
    
component MOALU is
    generic ( Nb : integer) ;
    port(x :in std_logic;
        clk :in std_logic; 
        reset :in std_logic;
        B_A :in std_logic; 
        Rout :out std_logic_vector(Nb-1 downto 0);
        RARB :out std_logic);
end component;

constant N :integer := 3;
signal clk_int :std_logic := '0';
signal reset_int :std_logic := '0';
signal x_int :std_logic := '0';
signal B_A :std_logic := '0';

begin

clk_gen: process
begin
-- clock must start LOW
clk_int <= '0'; wait for 5 ns;
clk_int <= '1'; wait for 5 ns;
end process;

reset_gen: process
begin
reset_int <= '1'; wait for 242 ns;
reset_int <= '0'; wait for 3 ns;
reset_int <= '1'; wait for 50 ns;
end process;

x_gen: process
begin
x_int <= '0'; wait for 15 ns;
x_int <= '1'; wait for 10 ns;
x_int <= '0'; wait for 10 ns;
end process;

MOALU1: MOALU 
    generic map (Nb => N)
    port map(x_int, clk_int, reset_int, B_A);
   
end tb_MOALU_behavior;