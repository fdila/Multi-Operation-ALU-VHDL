library ieee;
use ieee.std_logic_1164.all;

entity sipo is
	generic(Nb : integer);
	port(
		clk, reset : in std_logic;
		data_in : in std_logic;
		enable : in std_logic;
		data_out : out std_logic_vector(Nb - 1 downto 0) := (others => '0')
		);
end entity sipo;

architecture sipo_behavior of sipo is
    signal data_complete :std_logic := '0';
    begin
    clocked_sipo: process (clk, reset) is
        variable temp :std_logic_vector(Nb - 1 downto 0) := (others => '0');
        variable counter :integer := 0;
        begin
            if (reset = '0') then
                data_out <= (others => 'Z');
                temp := (others => '0');
                counter := 0;
            else
                if (rising_edge(clk)) then
                    if enable = '1' then
                        if counter < Nb then
                            counter := counter + 1;
                            temp := temp(Nb - 2 downto 0) & data_in;
                        if counter = Nb then
                            counter := 0;
                            data_out <= temp(Nb - 1 downto 0);
                            temp :=  (others => '0');
                        end if;                        
                        end if;
                    end if;
                end if;
            end if;
    end process;
end architecture sipo_behavior; 