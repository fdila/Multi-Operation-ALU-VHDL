library ieee;
use ieee.std_logic_1164.all;

entity FSM is
    port(X :in std_logic;
        clk, enable :in std_logic;
        reset :in std_logic;
        outputstate :out std_logic_vector(2 downto 0)); 
end FSM;

architecture FSM_behav of FSM is
    TYPE statetype IS (START, S0, S1, S00, S01, S11, S10, SB, TX, ADD, C2, SUB, COMP, RX, ERR);
    signal currentstate, nextstate: statetype;
    signal finalstate: std_logic_vector(2 downto 0); 
begin

fsm_flow: process(clk)
begin
    if rising_edge(clk) then
        if enable='1' then
            case currentstate is 
                when START =>
                    case X is 
                        when "0" => nextstate <= S0; 
                        when "1" => nextstate <= S1; 
                    end case;
                when S0 =>
                    case X is 
                        when "0" => nextstate <= S00; 
                        when "1" => nextstate <= S01; 
                    end case;
                when S1 =>
                    case X is 
                        when "0" => nextstate <= S10; 
                        when "1" => nextstate <= S11; 
                    end case;
                when S00 =>
                    case X is 
                        when "0" => nextstate <= SB; 
                        when "1" => nextstate <= TX; 
                    end case;
                when S01 =>
                    case X is 
                        when "0" => nextstate <= ADD; 
                        when "1" => nextstate <= C2; 
                    end case;
                when S10 =>
                    case X is 
                        when "0" => nextstate <= SUB; 
                        when "1" => nextstate <= COMP; 
                    end case;
                when S11 =>
                    case X is 
                        when "0" => nextstate <= ERR; 
                        when "1" => nextstate <= RX; 
                    end case;
                when SB =>
                    case X is
                        when "0" => nextstate <= S0;
                        when "1" => nextstate <= S1;
                    end case;
                when TX =>
                    case X is
                        when "0" => nextstate <= S0;
                        when "1" => nextstate <= S1;
                    end case;
                when ADD =>
                    case X is
                        when "0" => nextstate <= S0;
                        when "1" => nextstate <= S1;
                    end case;
                when C2 =>
                    case X is
                        when "0" => nextstate <= S0;
                        when "1" => nextstate <= S1;
                    end case;
                when SUB =>
                    case X is
                        when "0" => nextstate <= S0;
                        when "1" => nextstate <= S1;
                    end case;
                when COMP =>
                    case X is
                        when "0" => nextstate <= S0;
                        when "1" => nextstate <= S1;
                    end case;
                when ERR =>
                    case X is
                        when "0" => nextstate <= S0;
                        when "1" => nextstate <= S1;
                    end case;
                when RX =>
                    case X is
                        when "0" => nextstate <= S0;
                        when "1" => nextstate <= S1;
                    end case;
            end case;
        end if; -- end if enable
    end if; -- end if rising_edge
currentstate <= nextstate;
end process;

fsm_out: process(currentstate)
begin 
    case currentstate is
        when SB => finalstate <= "000";
        when TX => finalstate <= "001";
        when ADD => finalstate <= "010";
        when C2 => finalstate <= "011";
        when SUB => finalstate <= "100";
        when COMP => finalstate <= "101";
        when ERR => finalstate <= "000";
        when RX => finalstate <= "111";
    end case;
outputstate <= finalstate;
end process;

fsm_reset: process(reset)
begin
    if reset='0' then
       currentstate <= START;
       finalstate <= "000";
    end if; -- end if reset
end process;

end FSM_behav;