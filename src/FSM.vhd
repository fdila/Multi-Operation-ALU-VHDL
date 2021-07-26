library ieee;
use ieee.std_logic_1164.all;

entity FSM is
    port(X :in std_logic;
        clk, enable :in std_logic;
        reset :in std_logic;
        outputstate :out std_logic_vector(2 downto 0)); 
end FSM;

architecture FSM_behav of FSM is
    TYPE statetype IS (START, S0, S1, S00, S01, S11, S10, STANDBY, TX, ADD, C2, SUB, COMP, RX, ERR);
    signal currentstate: statetype := START;
    
begin

fsm_flow: process(clk, reset)
variable nextstate: statetype; 
begin
    if reset='0' then
        currentstate <= START;
        else if rising_edge(clk) then
            if enable='1' then
                case currentstate is 
                    when START =>
                        case X is 
                            when '0' => nextstate := S0;
                            when '1' => nextstate := S1;
                            when others => nextstate := ERR;
                        end case;
                    when S0 =>
                        case X is 
                            when '0' => nextstate := S00;
                            when '1' => nextstate := S01;
                            when others => nextstate := ERR;
                        end case;
                    when S1 =>
                        case X is 
                            when '0' => nextstate := S10;
                            when '1' => nextstate := S11;
                            when others => nextstate := ERR;
                        end case;
                    when S00 =>
                        case X is 
                            when '0' => nextstate := STANDBY;
                            when '1' => nextstate := TX;
                            when others => nextstate := ERR;
                        end case;
                    when S01 =>
                        case X is 
                            when '0' => nextstate := ADD;
                            when '1' => nextstate := C2;
                            when others => nextstate := ERR;
                        end case;
                    when S10 =>
                        case X is 
                            when '0' => nextstate := SUB;
                            when '1' => nextstate := COMP;
                            when others => nextstate := ERR;
                        end case;
                    when S11 =>
                        case X is 
                            when '0' => nextstate := ERR;
                            when '1' => nextstate := RX;
                            when others => nextstate := ERR;
                        end case;
                    when STANDBY =>
                        case X is
                            when '0' => nextstate := S0;
                            when '1' => nextstate := S1;
                            when others => nextstate := ERR;
                        end case;
                    when TX =>
                        case X is
                            when '0' => nextstate := S0;
                            when '1' => nextstate := S1;
                            when others => nextstate := ERR;
                        end case;
                    when ADD =>
                        case X is
                            when '0' => nextstate := S0;
                            when '1' => nextstate := S1;
                            when others => nextstate := ERR;
                        end case;
                    when C2 =>
                        case X is
                            when '0' => nextstate := S0;
                            when '1' => nextstate := S1;
                            when others => nextstate := ERR;
                        end case;
                    when SUB =>
                        case X is
                            when '0' => nextstate := S0;
                            when '1' => nextstate := S1;
                            when others => nextstate := ERR;
                        end case;
                    when COMP =>
                        case X is
                            when '0' => nextstate := S0;
                            when '1' => nextstate := S1;
                            when others => nextstate := ERR;
                        end case;
                    when ERR =>
                        case X is
                            when '0' => nextstate := S0;
                            when '1' => nextstate := S1;
                            when others => nextstate := ERR;
                        end case;
                    when RX =>
                        case X is
                            when '0' => nextstate := S0;
                            when '1' => nextstate := S1;
                            when others => nextstate := ERR;
                        end case;
                end case;
            end if; -- end if enable
        currentstate <= nextstate;
        end if; -- end else if
    end if; -- end if 
end process;

fsm_out: process(currentstate)
variable finalstate: std_logic_vector(2 downto 0) := "UUU"; 
begin 
    case currentstate is
        when START => finalstate := "000";
        when STANDBY => finalstate := "000";
        when TX => finalstate := "001";
        when ADD => finalstate := "010";
        when C2 => finalstate := "011";
        when SUB => finalstate := "100";
        when COMP => finalstate := "101";
        when ERR => finalstate := "000";
        when RX => finalstate := "111";
        when others => null;
    end case;
    if (finalstate /= "UUU") then
        outputstate <= finalstate;
    end if;
end process;

end FSM_behav;
