library ieee;
use ieee.std_logic_1164.all;
 
entity test_FSM is
    end test_FSM;
    
architecture test_FSM_behavior of test_FSM is
    
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

begin
    
clk_gen: process
begin
clk_int <= '1'; wait for 5 ns;
clk_int <= '0'; wait for 5 ns;
end process;

x_gen: process
begin
x_int <= '0'; wait for 10 ns;
x_int <= '1'; wait for 10 ns;
end process;

FSM1: FSM port map(x_int, clk_int, '1', '0', outint);
   
end test_FSM_behavior;
