library ieee;
use ieee.std_logic_1164.all;
 
entity tb_FSM is
    end tb_FSM;
    
architecture tb_FSM_behavior of tb_FSM is
    
component FSM is 
port(
    X :in std_logic;
    clk, enable :in std_logic;
    reset :in std_logic;
    outputstate :out std_logic_vector(2 downto 0));
end component;

signal x_int, enable_int, reset_int: std_logic;
signal clk_int: std_logic;
signal outint: std_logic_vector(2 downto 0);

-- run simulation for 300 ns for all cases!
begin

clk_gen: process
begin
-- clock must start LOW
clk_int <= '0'; wait for 5 ns;
clk_int <= '1'; wait for 5 ns;
end process;

enable_gen: process
begin
enable_int <= '1'; wait for 290 ns;
enable_int <= '0'; wait for 10 ns;
end process;

reset_gen: process
begin
reset_int <= '1'; wait for 242 ns;
reset_int <= '0'; wait for 3 ns;
reset_int <= '1'; wait for 50 ns;
end process;

x_gen: process
begin
-- stand-by
x_int <= '0'; wait for 10 ns;
x_int <= '0'; wait for 10 ns;
x_int <= '0'; wait for 10 ns;

-- tx
x_int <= '0'; wait for 10 ns;
x_int <= '0'; wait for 10 ns;
x_int <= '1'; wait for 10 ns;

-- add
x_int <= '0'; wait for 10 ns;
x_int <= '1'; wait for 10 ns;
x_int <= '0'; wait for 10 ns;

-- c2
x_int <= '0'; wait for 10 ns;
x_int <= '1'; wait for 10 ns;
x_int <= '1'; wait for 10 ns;

-- sub
x_int <= '1'; wait for 10 ns;
x_int <= '0'; wait for 10 ns;
x_int <= '0'; wait for 10 ns;

-- comp
x_int <= '1'; wait for 10 ns;
x_int <= '0'; wait for 10 ns;
x_int <= '1'; wait for 10 ns;

-- error
x_int <= '1'; wait for 10 ns;
x_int <= '1'; wait for 10 ns;
x_int <= '0'; wait for 10 ns;

-- rx
x_int <= '1'; wait for 10 ns;
x_int <= '1'; wait for 10 ns;
x_int <= '1'; wait for 10 ns;

-- rx (after reset)
x_int <= '1'; wait for 10 ns;
x_int <= '1'; wait for 10 ns;
x_int <= '1'; wait for 10 ns;
end process;

FSM1: FSM port map(x_int, clk_int, enable_int, reset_int, outint);
   
end tb_FSM_behavior;
