--COMPONENTES NECESSARIOS
library ieee;
use ieee.std_logic_1164.all;

entity decodificador8x11 is
    port(
    	instrin : in std_logic_vector(7 downto 0);
        instrout: out std_logic_vector(10 downto 0)
    );
end entity;

architecture comutar of decodificador8x11 is 

begin
    instrout(10) <= '1' when instrin = "00000000" else '0';
    instrout(9)  <= '1' when instrin = "00010000" else '0';
    instrout(8)  <= '1' when instrin = "00100000" else '0';
    instrout(7)  <= '1' when instrin = "00110000" else '0';
    instrout(6)  <= '1' when instrin = "01000000" else '0';
    instrout(5)  <= '1' when instrin = "01010000" else '0';
    instrout(4)  <= '1' when instrin = "01100000" else '0';
    instrout(3)  <= '1' when instrin = "10000000" else '0';
    instrout(2)  <= '1' when instrin = "10010000" else '0';
    instrout(1)  <= '1' when instrin = "10100000" else '0';
    instrout(0)  <= '1' when instrin = "11110000" else '0';   
end architecture;

--OBS: A PEQUENA UC ESTA NO ARQUIVO(pequenaUC.vhdl)
--OBS: REGISTRADORES ESTAO NO ARQUIVO (registradores.vhdl)

--MODULO UC
library ieee;
use ieee.std_logic_1164.all;

entity modulouc is
    port(
        barramento  : in  std_logic_vector(7 downto 0);
        enz    : in std_logic_vector(1 downto 0);
        cl, clk : in std_logic;
        rinrw  : in std_logic;
        sctrl : out std_logic_vector(10 downto 0)
        );
end entity;

architecture cerebro of modulouc is

component ri is
	port(        
	instrin : in  std_logic_vector(7 downto 0);        
	clk    : in  std_logic;        
	pr, cl : in  std_logic;                
	notrw  : in  std_logic;        
	instrout: out std_logic_vector(7 downto 0) 
	);
end component;

component decodificador8x11 is
    port(
    	instrin : in std_logic_vector(7 downto 0);
        instrout: out std_logic_vector(10 downto 0)
    );
end component;

component uc is
    port(
        dec2uc  : in  std_logic_vector(10 downto 0);
        nz  : in  std_logic_vector(1 downto 0);
        rst, clk : in std_logic;
        suc  : out std_logic_vector(10 downto 0)
        );
end component;

signal s_ri2dec : std_logic_vector(7 downto 0);
signal s_dec2uc : std_logic_vector(10 downto 0);
    
begin
	u_ri : ri    port map(barramento, clk, '1', cl, rinrw, s_ri2dec);
	u_decodificador : decodificador8x11 port map(s_ri2dec, s_dec2uc);
	u_littleuc : uc port map(s_dec2uc, enz, cl, clk, sctrl);
end architecture;
