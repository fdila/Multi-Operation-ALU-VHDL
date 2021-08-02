library ieee;
use ieee.std_logic_1164.all;
 
entity tb_pipo is
end tb_pipo;
    
architecture tb_pipo_behavior of tb_pipo is
    
component pipo is
    generic(Nb : integer);
	port(
		clk, reset : in std_logic;
		data_in : in std_logic_vector(Nb - 1 downto 0) := (others => '0');
		enable : in std_logic;
		data_out : out std_logic_vector(Nb - 1 downto 0) := (others => '0')
		);
end component;

constant N: integer := 3;
signal data_in :std_logic_vector(N - 1 downto 0);
signal clk_int, en_int, reset_int :std_logic;

begin
clk_gen: process
begin
-- clock must start LOW
clk_int <= '0'; wait for 5 ns;
clk_int <= '1'; wait for 5 ns;
end process;

reset_gen: process
begin
reset_int <= '1'; wait for 200 ns;
reset_int <= '0'; wait for 2 ns;
reset_int <= '1'; wait for 200 ns;

end process;

en_gen: process
begin
en_int <= '0'; wait for 5 ns;
en_int <= '1'; wait for 30 ns;
en_int <= '0'; wait for 10 ns;
en_int <= '1'; wait for 30 ns;
end process;

data_gen: process
begin
data_in <= "111"; wait for 10 ns; 
data_in <= "110"; wait for 10 ns; 
data_in <= "100"; wait for 10 ns; 
data_in <= "000"; wait for 10 ns;

data_in <= "001"; wait for 10 ns;
data_in <= "010"; wait for 10 ns;
data_in <= "011"; wait for 10 ns;
data_in <= "101"; wait for 10 ns;
end process;

pipoA: pipo 
    generic map (Nb => N)
    port map(clk_int, reset_int, data_in, en_int);
   
end tb_pipo_behavior;
