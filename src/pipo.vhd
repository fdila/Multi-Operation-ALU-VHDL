library ieee;
use ieee.std_logic_1164.all;

entity pipo is
	generic(Nb : integer);
	port(
		clk, reset : in std_logic;
		data_in : in std_logic_vector(Nb - 1 downto 0) := (others => '0');
		enable : in std_logic;
		data_out : out std_logic_vector(Nb - 1 downto 0) := (others => '0')
		);
end entity pipo;

architecture pipo_behavior of pipo is
    begin
    clocked_pipo: process (clk, reset) is
        variable temp :std_logic_vector(Nb - 1 downto 0) := (others => '0');
        begin
            if (reset = '0') then
                data_out <= (others => 'Z');
                temp := (others => '0');
            else
                if (falling_edge(clk)) then
                    if enable = '1' then
                        temp := data_in;
                        data_out <= temp;
                       
                    end if;
                end if;
            end if;
    end process;
end architecture pipo_behavior; 