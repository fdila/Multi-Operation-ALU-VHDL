library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
	generic(Nb : integer);
	port(
        a,b :in std_logic_vector(Nb - 1 downto 0);
        opcode :in std_logic_vector(2 downto 0);
        B_A :in std_logic;
		enable : in std_logic;
		result : out std_logic_vector(Nb - 1 downto 0) := (others => '0')
		);
end entity ALU;

architecture ALU_behavior of ALU is
begin
    process (a, b, opcode, B_A, enable) is
        variable temp :unsigned(Nb - 1 downto 0) := (others => '0');
        begin
            if (enable = '1') then
                case opcode is
                    when "010" =>
                        temp := unsigned(a) + unsigned(b);
                    when "011" =>
                        if B_A = '0' then
                            temp := unsigned(not a) + 1;
                        else
                            if B_A = '1' then
                                temp := unsigned(not b) + 1;
                            end if;
                        end if;
                    when "100" =>
                        if B_A = '0' then
                            temp := unsigned(a) + (unsigned((not B)) + 1);
                        else
                            if B_A = '1' then
                                temp := unsigned(b) +  (unsigned((not A)) + 1);
                            end if;
                        end if;
                    when "101" =>
                        if A = B then
                            temp := (others => '0');
                            temp := temp + 1;
                        else
                            temp := (others => '0');
                        end if;
                    when others =>
                        null;
                end case;
            result <= std_logic_vector(temp);
            end if;
    end process;

end architecture ALU_behavior;