library ieee;
use ieee.std_logic_1164.all;

entity MOALU is
    generic ( Nb : integer) ;
    port(x :in std_logic;
        clk :in std_logic; 
        reset :in std_logic;
        B_A :in std_logic; 
        Rout :out std_logic_vector(Nb-1 downto 0);
        RARB :out std_logic);
end MOALU;

architecture MOALU_behavior of MOALU is
	component sipo is
		generic(Nb : integer);
        port(
            clk, reset : in std_logic;
            data_in : in std_logic;
            enable : in std_logic;
            data_out : out std_logic_vector(Nb - 1 downto 0) := (others => '0')
            );
	end component;

	component FSM_bella is
		generic (Nb : integer);
        port(opcode :in std_logic_vector(2 downto 0);
            clk, reset :in std_logic;
            ALU_en :out std_logic := '0';
            piso_rarb_en :out std_logic :='0';
            pipo_rout_en :out std_logic := '0';
            RARB_select :out std_logic := '0';
            sipo_A_en :out std_logic := '0';
            sipo_B_en :out std_logic := '0';
            sipo_opcode_en :out std_logic := '0');
	end component;

    signal opcode_int :std_logic_vector(2 downto 0) := "000";

    signal ALU_en :std_logic := '0';
    signal piso_rarb_en :std_logic :='0';
    signal pipo_rout_en :std_logic := '0';
    signal RARB_select :std_logic := '0';
    signal sipo_A_en :std_logic := '0';
    signal sipo_B_en :std_logic := '0';
    signal sipo_opcode_en :std_logic := '0';

	begin
        sipo_opcode_is : sipo
			generic map(3)
            port map(clk, reset, x, sipo_opcode_en, opcode_int);

		fsm_is : FSM_bella
			generic map(Nb)
            port map(opcode_int, clk, reset, ALU_en, piso_rarb_en, pipo_rout_en, RARB_select, sipo_A_en, sipo_B_en, sipo_opcode_en);
		

end  MOALU_behavior;