library ieee;
use ieee.std_logic_1164.all;
 
entity tb_FSM is
end tb_FSM;
    
architecture tb_FSM_behavior of tb_FSM is
    
component FSM is
    generic (Nb : integer);
    port(x :in std_logic := '0';
        clk, reset :in std_logic;
        ALU_en :out std_logic := '0';
        alu_op :out std_logic_vector(1 downto 0) := (others => '0');
        RARB_select :out std_logic := '0';
        piso_rarb_en :out std_logic :='0';
        piso_rarb_write :out std_logic :='0';
        pipo_rout_en :out std_logic := '0';
        sipo_A_en :out std_logic := '0';
        sipo_B_en :out std_logic := '0'
        );
end component;

signal x_int, clk_int, reset_int :std_logic;
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
reset_int <= '0'; wait for 2 ns;
reset_int <= '1'; wait for 500 ns;
end process;

x_gen: process
begin
x_int <= '0'; wait for 10 ns;

x_int <= '1'; wait for 10 ns;
x_int <= '1'; wait for 10 ns;
x_int <= '1'; wait for 10 ns; -- should go in rx

x_int <= '0'; wait for 40 ns; -- wait for rx to finish

x_int <= '0'; wait for 10 ns;
x_int <= '1'; wait for 10 ns;
x_int <= '1'; wait for 10 ns; -- should go in ALU / alu_op 01
end process;

FSM1: FSM 
    generic map (Nb => N)
    port map(x_int, clk_int, reset_int);
   
end tb_FSM_behavior;
