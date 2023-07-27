
library ieee;
use ieee.std_logic_1164.all;

entity tbneander is
end tbneander;

architecture test of tbneander is

constant CLK_PERIOD : time := 20 ns;

    component neander is
	port(
            rst, clk    : in    std_logic
        );
    end component;



signal s_rst : std_logic;
signal s_clk : std_logic := '1';

begin

    unity_neander : neander port map(s_rst, s_clk);

    tbp : process
    begin
         
        s_rst <= '0';
          
    wait for CLK_PERIOD;
    
    	s_rst <= '1';
    	
    wait;
    
    end process;    
   
    p_clkc : process
    begin            
        s_clk <= not(s_clk);
        wait for CLK_PERIOD/2; 
    end process;
end architecture test;
