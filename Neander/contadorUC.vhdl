--COMPONENTES NECESSARIOS
library ieee;
use ieee.std_logic_1164.all;

entity ffjk is
    port(
        j, k   : in std_logic;
        clk    : in std_logic;
        pr, cl : in std_logic;
        q, nq  : out std_logic
    );
end entity;

architecture latch of ffjk is
    signal sq  : std_logic := '0';
    signal snq : std_logic := '1';
begin

    q  <= sq;
    nq <= snq;

    u_ff : process (clk, pr, cl)
    begin
        if (pr = '0') and (cl = '0') then
            sq  <= 'X';
            snq <= 'X';
            elsif (pr = '1') and (cl = '0') then
                sq  <= '0';
                snq <= '1';
                elsif (pr = '0') and (cl = '1') then
                    sq  <= '1';
                    snq <= '0';
                    elsif (pr = '1') and (cl = '1') then
                        if falling_edge(clk) then
                            if    (j = '0') and (k = '0') then
                                sq  <= sq;
                                snq <= snq;
                            elsif (j = '0') and (k = '1') then
                                sq  <= '0';
                                snq <= '1';
                            elsif (j = '1') and (k = '0') then
                                sq  <= '1';
                                snq <= '0';
                            elsif (j = '1') and (k = '1') then
                                sq  <= not(sq);
                                snq <= not(snq);
                            else
                                sq  <= 'U';
                                snq <= 'U';
                            end if;
                        end if;
            else
                sq  <= 'X';
                snq <= 'X';
        end if;
    end process;

end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity controle is
    port(
        qq  : in  std_logic_vector(2 downto 0);
        jj, kk : out std_logic_vector(2 downto 0)
        );
end entity;

architecture controlar of controle is
    
begin    
	jj(0) <= '1';
	kk(0) <= '1';
	
	jj(1) <= qq(0);
	kk(1) <= qq(0);
	
	jj(2) <= qq(1) and qq(0);
	kk(2) <= qq(1) and qq(0);   
end architecture controlar;

--COUNTER
library ieee;
use ieee.std_logic_1164.all;

entity contador is
    port(
        clkc, reset  : in  std_logic;
        c  : out std_logic_vector(2 downto 0)
        );
end entity;

architecture contar of contador is

component ffjk is
    port(
        j, k   : in  std_logic;
        clk  : in  std_logic;
        pr, cl : in  std_logic;
        q, nq  : out std_logic
        );
end component;

component controle is
    port(
        qq  : in  std_logic_vector(2 downto 0);
        jj, kk  : out std_logic_vector(2 downto 0)
        );
end component;

signal sjj, skk, sq : std_logic_vector(2 downto 0);
signal vcc : std_logic := '1';
    
begin
	unity_ff0 : ffjk port map(sjj(0), skk(0), clkc, vcc, reset, sq(0));
	unity_ff1 : ffjk port map(sjj(1), skk(1), clkc, vcc, reset, sq(1));
	unity_ff2 : ffjk port map(sjj(2), skk(2), clkc, vcc, reset, sq(2));
	
	unity_ctrl : controle port map (sq, sjj, skk);
	
	c <= sq;	
end architecture contar;
