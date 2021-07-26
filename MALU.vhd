library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity MALU is
    generic ( Nb : integer) ;
    port(X :in std_logic;
        clk, enable :in std_logic; 
        reset :in std_logic
        AB :in std_logic; 
        Rout :out std_logic_vector(Nb-1 downto 0);
        RAB :out std_logic);
    end MALU;

