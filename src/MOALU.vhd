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

    component ALU is
        generic(Nb : integer);
	    port(
        a,b :in std_logic_vector(Nb - 1 downto 0);
        opcode :in std_logic_vector(2 downto 0);
        B_A :in std_logic;
		enable : in std_logic;
		result : out std_logic_vector(Nb - 1 downto 0) := (others => '0')
		);
    end component;

	component FSM is
		generic (Nb : integer);
        port(opcode :in std_logic_vector(2 downto 0);
            clk, reset :in std_logic;
            ALU_en :out std_logic := '0';
            piso_rarb_en :out std_logic :='0';
            piso_rarb_write :out std_logic :='0';
            pipo_rout_en :out std_logic := '0';
            RARB_select :out std_logic := '0';
            sipo_A_en :out std_logic := '0';
            sipo_B_en :out std_logic := '0';
            sipo_opcode_en :out std_logic := '0');
	end component;

    component mux is 
        generic(Nb : integer);
	    port(
		data_in1 : in std_logic_vector(Nb - 1 downto 0) := (others => '0');
        data_in2 : in std_logic_vector(Nb - 1 downto 0) := (others => '0');
		select_sig : in std_logic;
		data_out : out std_logic_vector(Nb - 1 downto 0) := (others => '0')
		);
    end component;

    component piso is
        generic(Nb : integer);
	    port(
		clk, reset : in std_logic;
		data_in : in std_logic_vector(Nb - 1 downto 0) := (others => '0');
		enable : in std_logic;
        write_trans : in std_logic := '1';
		data_out : out std_logic
		);
    end component;

    component pipo is
        generic(Nb : integer);
	    port(
		clk, reset : in std_logic;
		data_in : in std_logic_vector(Nb - 1 downto 0) := (others => '0');
		enable : in std_logic;
		data_out : out std_logic_vector(Nb - 1 downto 0) := (others => '0')
		);
    end component;

    signal opcode_int :std_logic_vector(2 downto 0) := "000";

    signal sipo_a_out :std_logic_vector(Nb - 1 downto 0);
    signal sipo_b_out :std_logic_vector(Nb - 1 downto 0);

    signal alu_result :std_logic_vector(Nb - 1 downto 0);

    signal ALU_en :std_logic := '0';
    signal piso_rarb_en :std_logic :='0';
    signal piso_rarb_write :std_logic :='0';
    signal pipo_rout_en :std_logic := '0';
    signal RARB_select :std_logic := '0';
    signal sipo_A_en :std_logic := '0';
    signal sipo_B_en :std_logic := '0';
    signal sipo_opcode_en :std_logic := '0';

    signal mux_rarb_out :std_logic_vector(Nb - 1 downto 0);

	begin
        sipo_opcode_is : sipo
			generic map(3)
            port map(clk, reset, x, sipo_opcode_en, opcode_int);
        
        sipo_A_is : sipo
			generic map(Nb)
            port map(clk, reset, x, sipo_A_en, sipo_a_out);    

        sipo_B_is : sipo
			generic map(Nb)
            port map(clk, reset, x, sipo_B_en, sipo_b_out);

	    fsm_is : FSM
			generic map(Nb)
            port map(opcode_int, clk, reset, ALU_en, piso_rarb_en, piso_rarb_write, pipo_rout_en, RARB_select, sipo_A_en, sipo_B_en, sipo_opcode_en);
        
        mux_rarb_is : mux
            generic map(Nb)
            port map(sipo_a_out, sipo_b_out, RARB_select, mux_rarb_out);
        
	    piso_ra_rb : piso
		    generic map(Nb)
		    port map(clk, reset, mux_rarb_out, piso_rarb_en, piso_rarb_write, RARB);

        pipo_rout : pipo
            generic map(Nb)
            port map (clk, reset, alu_result, pipo_rout_en, Rout);
        
        ALU_is : ALU
	    generic map(Nb)
            port map(sipo_a_out, sipo_b_out, opcode_int, B_A, ALU_en, alu_result);
		

end  MOALU_behavior;