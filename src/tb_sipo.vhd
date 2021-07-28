library ieee;
use ieee.std_logic_1164.all;
 
entity tb_sipo is
end tb_sipo;
    
architecture tb_sipo_behavior of tb_sipo is
    
component sipo is
    generic(Nb : integer);
	port(
		clk, reset : in std_logic;
		data_in : in std_logic;
		enable : in std_logic;
		data_out : out std_logic_vector(Nb - 1 downto 0) := (others => '0')
		);
end component;

signal data_in_int :std_logic;
signal clk_int, reset_int :std_logic;
constant N: integer := 3;

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

data_gen: process
begin
data_in_int <= '0'; wait for 15 ns; 
data_in_int <= '1'; wait for 10 ns; 
data_in_int <= '0'; wait for 10 ns;
data_in_int <= '0'; wait for 10 ns; 
data_in_int <= '1'; wait for 10 ns; 
data_in_int <= '1'; wait for 10 ns; 
end process;

sipoA: sipo 
    generic map (Nb => N)
    port map(clk_int, reset_int, data_in_int, '1');
   
end tb_sipo_behavior;
