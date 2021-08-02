library ieee;
use ieee.std_logic_1164.all;

entity mux is
	generic(Nb : integer);
	port(
		data_in1 : in std_logic_vector(Nb - 1 downto 0) := (others => '0');
        data_in2 : in std_logic_vector(Nb - 1 downto 0) := (others => '0');
		select_sig : in std_logic;
		data_out : out std_logic_vector(Nb - 1 downto 0) := (others => '0')
		);
end entity mux;

architecture mux_behavior of mux is
    begin
    process(data_in1, data_in2, select_sig)is
        variable temp :std_logic_vector(Nb - 1 downto 0) := (others => '0');
        begin
            case select_sig is
                when '0' =>
                    temp := data_in1;
                when '1' =>
                    temp := data_in2;
                when others =>
                    temp := (others => '0');                      
            end case;
            data_out <= temp;
    end process;
end mux_behavior;