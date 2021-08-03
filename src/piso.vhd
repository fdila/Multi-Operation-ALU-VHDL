library ieee;
use ieee.std_logic_1164.all;

entity piso is
	generic(Nb : integer);
	port(
		clk, reset : in std_logic;
		data_in : in std_logic_vector(Nb - 1 downto 0) := (others => '0');
		enable : in std_logic;
        write_trans : in std_logic := '1';
		data_out : out std_logic
		);
end entity piso;

architecture piso_behavior of piso is
    signal data :std_logic_vector(Nb - 1 downto 0);
    begin
    clocked_piso: process (clk, reset) is
        variable temp :std_logic_vector(Nb - 1 downto 0) := (others => '0');
        begin
            if (reset = '0') then
                data_out <= '0';
                temp := (others => '0');
            else
                if enable = '1' then                  
                    if (rising_edge(clk)) and write_trans = '1' then
                        temp := data_in;
                        data <= temp;
                        data_out <= temp(Nb-1);
                    end if;
 
                    if (rising_edge(clk)) and write_trans = '0' then
                        temp := '1' & temp(Nb - 2 downto 0) ;
                        data <= temp;
                        data_out <= temp(0);
                    end if;

                end if;
            end if;
    end process;
end architecture piso_behavior; 