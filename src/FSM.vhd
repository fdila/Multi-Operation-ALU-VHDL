library ieee;
use ieee.std_logic_1164.all;

entity FSM is
    generic (Nb : integer);
    port(x :in std_logic := '0';
        clk, reset :in std_logic;
        ALU_en :out std_logic := '0';
        piso_rarb_en :out std_logic :='0';
        piso_rarb_write :out std_logic :='0';
        pipo_rout_en :out std_logic := '0';
        RARB_select :out std_logic := '0';
        sipo_A_en :out std_logic := '0';
        sipo_B_en :out std_logic := '0';
        sipo_opcode_en :out std_logic := '0');
end FSM;

architecture FSM_behav of FSM is
    TYPE statetype IS (WAIT_OP, STANDBY, WRITE_PISO_A, WRITE_PISO_B, TX_A, TX_B, ALU, ERR, RX_A, RX_B);
    signal currentstate :statetype := WAIT_OP;
    signal op_debug :std_logic_vector(2 downto 0) := (others => '0');
begin

fsm_flow: process(clk, reset)
variable nextstate: statetype;
variable counter :integer := 0; 
variable opcode :std_logic_vector(2 downto 0) := (others => '0');

begin
    if reset='0' then
        currentstate <= STANDBY;
    else 
        if rising_edge(clk) then
            case currentstate is
                when WAIT_OP =>
                    if counter < 3 then
                        nextstate := WAIT_OP;
                        opcode := opcode(1 downto 0) & x;
                        op_debug <= opcode;
                        counter := counter + 1;
                    end if;
                    if counter = 3 then
                        case opcode is
                            when "000" => nextstate := STANDBY;
                            when "001" => nextstate := WRITE_PISO_A;
                            when "010" => nextstate := ALU;
                            when "011" => nextstate := ALU;
                            when "100" => nextstate := ALU;
                            when "101" => nextstate := ALU;
                            when "110" => nextstate := ERR;
                            when "111" => nextstate := RX_A;
                            when others => nextstate := ERR;
                        end case;
                        counter := 0;
                        opcode := (others => '0');
                    end if;
                when STANDBY =>
                    nextstate := WAIT_OP;
                when WRITE_PISO_A =>
                    nextstate := TX_A;
                when WRITE_PISO_B =>
                    nextstate := TX_B;
                when TX_A =>
                    if counter < Nb - 1 then
                        nextstate := TX_A;
                        counter := counter + 1;
                    else
                        counter := 0;
                        nextstate := WRITE_PISO_B;
                    end if;
                when TX_B =>
                    if counter < Nb - 1 then
                        nextstate := TX_B;
                        counter := counter + 1;
                    else
                        counter := 0;
                        nextstate := WAIT_OP;
                    end if;
                when ALU =>
                    nextstate := WAIT_OP;
                when ERR =>
                    nextstate := WAIT_OP;
                when RX_A =>
                    if counter < Nb - 1 then
                        nextstate := RX_A;
                        counter := counter + 1;
                    else
                        counter := 0;
                        nextstate := RX_B;
                    end if;
                when RX_B =>
                    if counter < Nb - 1 then
                        nextstate := RX_B;
                        counter := counter + 1;
                    else
                        counter := 0;
                        nextstate := WAIT_OP;
                    end if;
            end case; -- end case currentstate
        currentstate <= nextstate;
        end if; -- end if rising edge
    end if; -- end if reset
end process;

fsm_out: process(currentstate)
    begin 
        case currentstate is
            when WAIT_OP =>
                ALU_en <= '0';
                piso_rarb_en <= '0';
                piso_rarb_write <= '0';
                pipo_rout_en <= '0';
                RARB_select <= '0';
                sipo_A_en <= '0';
                sipo_B_en <= '0';
                sipo_opcode_en <= '1';
            when STANDBY =>
                ALU_en <= '0';
                piso_rarb_en <= '0';
                piso_rarb_write <= '0';
                pipo_rout_en <= '0';
                RARB_select <= '0';
                sipo_A_en <= '0';
                sipo_B_en <= '0';
                sipo_opcode_en <= '0';
            when WRITE_PISO_A =>
                ALU_en <= '0';
                piso_rarb_en <= '1';
                piso_rarb_write <= '1';
                pipo_rout_en <= '0';
                RARB_select <= '0';
                sipo_A_en <= '0';
                sipo_B_en <= '0';
                sipo_opcode_en <= '0';
            when WRITE_PISO_B =>
                ALU_en <= '0';
                piso_rarb_en <= '1';
                piso_rarb_write <= '1';
                pipo_rout_en <= '0';
                RARB_select <= '1';
                sipo_A_en <= '0';
                sipo_B_en <= '0';
                sipo_opcode_en <= '0';
            when TX_A =>
                ALU_en <= '0';
                piso_rarb_en <= '1';
                piso_rarb_write <= '0';
                pipo_rout_en <= '0';
                RARB_select <= '0';
                sipo_A_en <= '0';
                sipo_B_en <= '0';
                sipo_opcode_en <= '0';
            when TX_B =>
                ALU_en <= '0';
                piso_rarb_en <= '1';
                piso_rarb_write <= '0';
                pipo_rout_en <= '0';
                RARB_select <= '0';
                sipo_A_en <= '0';
                sipo_B_en <= '0';
                sipo_opcode_en <= '0';
            when ALU =>
                ALU_en <= '1';
                piso_rarb_en <= '0';
                piso_rarb_write <= '0';
                pipo_rout_en <= '1';
                RARB_select <= '0';
                sipo_A_en <= '0';
                sipo_B_en <= '0';
                sipo_opcode_en <= '0';
            when ERR =>
                ALU_en <= '0';
                piso_rarb_en <= '0';
                piso_rarb_write <= '0';
                pipo_rout_en <= '0';
                RARB_select <= '0';
                sipo_A_en <= '0';
                sipo_B_en <= '0';
                sipo_opcode_en <= '1';
            when RX_A =>
                ALU_en <= '0';
                piso_rarb_en <= '0';
                piso_rarb_write <= '0';
                pipo_rout_en <= '0';
                RARB_select <= '0';
                sipo_A_en <= '1';
                sipo_B_en <= '0';
                sipo_opcode_en <= '0';
            when RX_B =>
                ALU_en <= '0';
                piso_rarb_en <= '0';
                piso_rarb_write <= '0';
                pipo_rout_en <= '0';
                RARB_select <= '0';
                sipo_A_en <= '0';
                sipo_B_en <= '1';
                sipo_opcode_en <= '0';
        end case; -- end case currentstate
end process;

end FSM_behav;
