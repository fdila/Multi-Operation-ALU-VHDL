library ieee;
use ieee.std_logic_1164.all;
 
entity tb_FSM_bella is
end tb_FSM_bella;
    
architecture tb_FSM_behavior of tb_FSM_bella is
    
component FSM_bella is
    generic (Nb : integer);
    port(opcode :in std_logic_vector(2 downto 0);
        clk, reset :in std_logic;
        ALU_en :out std_logic;
        piso_rarb_en :out std_logic;
        pipo_rout_en :out std_logic;
        RARB_select :out std_logic;
        sipo_A_en :out std_logic;
        sipo_B_en :out std_logic;
        sipo_opcode_en :out std_logic);
end component;

signal opcode_int :std_logic_vector(2 downto 0);
signal clk_int, reset_int :std_logic;
constant N: integer := 2;

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
opcode_int <= "000"; wait for 15 ns; -- should ignore this
opcode_int <= "111"; wait for 10 ns; -- should ignore this
opcode_int <= "111"; wait for 10 ns; -- should go to rx mode and receive 1 bit
opcode_int <= "000"; wait for 10 ns; -- should ignore this and receive 2 bit
opcode_int <= "111"; wait for 10 ns; -- should ignore this and receive 3 bit
opcode_int <= "000"; wait for 10 ns; -- should ignore this and receive 4 bit
opcode_int <= "111"; wait for 10 ns; -- should ignore this
opcode_int <= "111"; wait for 10 ns; -- should ignore this
opcode_int <= "011"; wait for 10 ns; -- should go to ALU mode
end process;

FSM1: FSM_bella 
    generic map (Nb => N)
    port map(opcode_int, clk_int, reset_int);
   
end tb_FSM_behavior;
