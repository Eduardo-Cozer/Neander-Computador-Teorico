--COMPONENTES NECESSARIOS

--OBS: O CONTADOR ESTA NO ARQUIVO (contadorUC.vhdl)

library ieee;
use ieee.std_logic_1164.all;

entity mux11x11 is
    port(
        bnop : in std_logic_vector(10 downto 0);
        bsta : in std_logic_vector(10 downto 0);
        blda : in std_logic_vector(10 downto 0);
        badd : in std_logic_vector(10 downto 0);
        band : in std_logic_vector(10 downto 0);
        bor  : in std_logic_vector(10 downto 0);
        bnot : in std_logic_vector(10 downto 0);
        bjmp : in std_logic_vector(10 downto 0);
        bjn  : in std_logic_vector(10 downto 0);
        bjz  : in std_logic_vector(10 downto 0);
        bhlt : in std_logic_vector(10 downto 0);
        selop: in std_logic_vector(10 downto 0);
        s : out std_logic_vector(10 downto 0)
    );
end entity;

architecture comutar of mux11x11 is 

begin
    s <= bnop when selop = "10000000000" else 
         bsta when selop = "01000000000" else
         blda when selop = "00100000000" else
         badd when selop = "00010000000" else
         band when selop = "00001000000" else
         bor  when selop = "00000100000" else
         bnot when selop = "00000010000" else
         bjmp when selop = "00000001000" else
         bjn  when selop = "00000000100" else
         bjz  when selop = "00000000010" else
         bhlt when selop = "00000000001" else
         (others => 'Z');
end architecture;

--OBS: OS CICLOS SE ENCONTRAM NO ARQUIVO(ciclosUC.vhdl)

--MODULO UC(pequena)
library ieee;
use ieee.std_logic_1164.all;

entity uc is
    port(
        dec2uc  : in  std_logic_vector(10 downto 0);
        nz  : in  std_logic_vector(1 downto 0);
        rst, clk : in std_logic;
        suc  : out std_logic_vector(10 downto 0)
        );
end entity;

architecture controlar of uc is

component contador is
    port(
        clkc, reset  : in  std_logic;
        c  : out std_logic_vector(2 downto 0)
        );
end component;

component ciclonop is
    port(
        ciclo    : in std_logic_vector(2 downto 0);
        snop     : out std_logic_vector(10 downto 0)
    );
end component;

component ciclosta is
    port(
        ciclo    : in std_logic_vector(2 downto 0);
       	ssta : out std_logic_vector(10 downto 0)
    );
end component;

component ciclolda is
    port(
        ciclo    : in std_logic_vector(2 downto 0);
       	slda : out std_logic_vector(10 downto 0)
    );
end component;

component cicloadd is
    port(
        ciclo    : in std_logic_vector(2 downto 0);
       	sadd : out std_logic_vector(10 downto 0)
    );
end component;

component cicloand is
    port(
        ciclo    : in std_logic_vector(2 downto 0);
       	sand : out std_logic_vector(10 downto 0)
    );
end component;

component cicloor is
    port(
        ciclo    : in std_logic_vector(2 downto 0);
       	sor : out std_logic_vector(10 downto 0)
    );
end component;

component ciclonot is
    port(
        ciclo    : in std_logic_vector(2 downto 0);
       	snot : out std_logic_vector(10 downto 0)
    );
end component;

component ciclojmp is
    port(
        ciclo    : in std_logic_vector(2 downto 0);
       	sjmp : out std_logic_vector(10 downto 0)
    );
end component;

component ciclojn is
	port(        
	ciclo : in  std_logic_vector(2 downto 0);               
	n: in std_logic;
	sjn: out std_logic_vector(10 downto 0)
	);
end component;

component ciclojz is
	port(        
	ciclo : in  std_logic_vector(2 downto 0);               
	z: in std_logic;
	sjz: out std_logic_vector(10 downto 0)
	);
end component;

component ciclohlt is
    port(
        ciclo    : in std_logic_vector(2 downto 0);
       	shlt : out std_logic_vector(10 downto 0)
    );
end component;

component mux11x11 is
    port(
        bnop : in std_logic_vector(10 downto 0);
        bsta : in std_logic_vector(10 downto 0);
        blda : in std_logic_vector(10 downto 0);
        badd : in std_logic_vector(10 downto 0);
        band : in std_logic_vector(10 downto 0);
        bor  : in std_logic_vector(10 downto 0);
        bnot : in std_logic_vector(10 downto 0);
        bjmp : in std_logic_vector(10 downto 0);
        bjn  : in std_logic_vector(10 downto 0);
        bjz  : in std_logic_vector(10 downto 0);
        bhlt : in std_logic_vector(10 downto 0);
        selop: in std_logic_vector(10 downto 0);
        s : out std_logic_vector(10 downto 0)
    );
end component;

signal s_nop, s_sta, s_lda, s_add, s_and, s_or, s_not, s_jmp, s_jn, s_jz, s_hlt : std_logic_vector(10 downto 0);
signal counter : std_logic_vector(2 downto 0);
    
begin
	u_counter : contador port map(clk, rst, counter);
	u_nop : ciclonop port map(counter, s_nop);
	u_sta : ciclosta port map(counter, s_sta);
	u_lda : ciclolda port map(counter, s_lda);
	u_add : cicloadd port map(counter, s_add);
	u_and : cicloand port map(counter, s_and);
	u_or  : cicloor  port map(counter, s_or);
	u_not : ciclonot port map(counter, s_not);
	u_jmp : ciclojmp port map(counter, s_jmp);
	u_jn  : ciclojn  port map(counter, nz(1), s_jn);
	u_jz  : ciclojz port map(counter, nz(0), s_jz);
	u_hlt : ciclohlt port map(counter, s_hlt);
	u_mux11x11 : mux11x11 port map(s_nop, s_sta, s_lda, s_add, s_and, s_or, s_not, s_jmp, s_jn, s_jz, s_hlt, dec2uc, suc);
end architecture;
