library ieee;
use ieee.std_logic_1164.all;

entity sipo is
    generic ( Nb : integer) ;
    port( DATA_IN  :in std_logic;
          clk      :in std_logic;
          enable   :in std_logic;   
          DATA_OUT :out std_logic_vector(Nb-1 downto 0)
    );
    end sipo;
    
architecture sipo_behavior of sipo is
		
	component flip_flop_D is
    port(D  :in  std_logic; 
         clk:in  std_logic;
         enable: in std_logic;
         Q  :out std_logic);
	end component;
	
   signal Din: std_logic;
   signal support_signal: std_logic_vector(Nb-1 downto 0);
	 
	begin
    
    DATA_OUT <= support_signal;
    
    n1 : flip_flop_D port map(DATA_IN, clk, enable, support_signal(0));
      
    g1 : for k in Nb-1 downto 1 generate
      ni : flip_flop_D port map(support_signal(k-1), clk, enable, support_signal(k));
        end generate;
   
end sipo_behavior;