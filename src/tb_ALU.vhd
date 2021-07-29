library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_ALU is
end tb_ALU;
    
architecture tb_ALU_behavior of tb_ALU is
    
component ALU is
    generic(Nb : integer);
	port(
        a,b :in std_logic_vector(Nb - 1 downto 0);
        opcode :in std_logic_vector(2 downto 0);
        B_A :in std_logic;
		enable : in std_logic;
		result : out std_logic_vector(Nb - 1 downto 0) := (others => '0')
		);
end component;

constant N: integer := 3;
signal a_int, b_int :std_logic_vector(N - 1 downto 0);
signal opcode_int :std_logic_vector(2 downto 0);
signal B_A_int, en_int :std_logic;


begin

A_gen: process
begin
a_int <= "101"; wait for 60 ns;
a_int <= "111"; wait for 10 ns;
end process;

B_gen: process
begin
b_int <= "010"; wait for 60 ns;
b_int <= "111"; wait for 10 ns;
end process;

opcode_gen: process
begin
opcode_int <= "010"; wait for 10 ns; --add

opcode_int <= "011"; wait for 10 ns; --C2
opcode_int <= "011"; wait for 10 ns; --C2

opcode_int <= "100"; wait for 10 ns; --sub
opcode_int <= "100"; wait for 10 ns; --sub

opcode_int <= "101"; wait for 10 ns; --comp
opcode_int <= "101"; wait for 10 ns; --comp
end process;

B_A_gen: process
begin
B_A_int <= '0'; wait for 20 ns;
B_A_int <= '1'; wait for 10 ns;
B_A_int <= '0'; wait for 10 ns;
B_A_int <= '1'; wait for 10 ns;

end process B_A_gen;

en_gen: process
begin
en_int <= '1'; wait for 2 ns;
en_int <= '0'; wait for 8 ns;
end process;

ALU1: ALU 
    generic map (Nb => N)
    port map(a_int, b_int, opcode_int, B_A_int, en_int);
   
end tb_ALU_behavior;
