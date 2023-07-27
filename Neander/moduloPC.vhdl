--COMPONENTES NECESSARIOS
library ieee;
use ieee.std_logic_1164.all;

entity mux2x8pc is
    port(
        c0 : in std_logic_vector(7 downto 0);
        c1 : in std_logic_vector(7 downto 0);
        sel: in std_logic;
        z : out std_logic_vector(7 downto 0)
    );
end entity;

architecture comutar of mux2x8pc is 

begin
    z <= c0 when sel = '0' else 
         c1 when sel = '1' else 
         "ZZZZZZZZ";
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity sumpc is
    port(
        x,y : in std_logic_vector(7 downto 0);
        cin: in std_logic;
        cout: out std_logic;
        sadd: out std_logic_vector(7 downto 0)
    );
end entity;

architecture comutar of sumpc is 

signal carry : std_logic_vector(7 downto 0);

begin
    sadd(0) <= (x(0) xor y(0)) xor cin;
    carry(0) <= (x(0) and y(0)) or (x(0) and cin) or (y(0) and cin);
    
    sadd(1) <= (x(1) xor y(1)) xor carry(0);
    carry(1) <= (x(1) and y(1)) or (x(1) and carry(0)) or (y(1) and carry(0));
    
    sadd(2) <= (x(2) xor y(2)) xor carry(1);
    carry(2) <= (x(2) and y(2)) or (x(2) and carry(1)) or (y(2) and carry(1));
    
    sadd(3) <= (x(3) xor y(3)) xor carry(2);
    carry(3) <= (x(3) and y(3)) or (x(3) and carry(2)) or (y(3) and carry(2));
    
    sadd(4) <= (x(4) xor y(4)) xor carry(3);
    carry(4) <= (x(4) and y(4)) or (x(4) and carry(3)) or (y(4) and carry(3));
    
    sadd(5) <= (x(5) xor y(5)) xor carry(4);
    carry(5) <= (x(5) and y(5)) or (x(5) and carry(4)) or (y(5) and carry(4));
    
    sadd(6) <= (x(6) xor y(6)) xor carry(5);
    carry(6) <= (x(6) and y(6)) or (x(6) and carry(5)) or (y(6) and carry(5));
    
    sadd(7) <= (x(7) xor y(7)) xor carry(6);
    carry(7) <= (x(7) and y(7)) or (x(7) and carry(6)) or (y(7) and carry(6));
   
    cout <= carry(7);	
end architecture;

--OBS: REGISTRADORES ESTAO NO ARQUIVO (registradores.vhdl)

--MODULO PC
library ieee;
use ieee.std_logic_1164.all;

entity modulopc is
	port(        
	barr : in  std_logic_vector(7 downto 0);        
	clk  : in  std_logic;        
	cl   : in  std_logic;                
	nbarrinc  : in  std_logic;    
	pc_rw  : in  std_logic;        
	endout: out std_logic_vector(7 downto 0) 
	);
end entity;

architecture programcounter of modulopc is
	component sumpc is
	    port(
		x,y : in std_logic_vector(7 downto 0);
		cin: in std_logic;
		cout: out std_logic;
		sadd: out std_logic_vector(7 downto 0)
	    );
	end component;
	
	component mux2x8pc is
	    port(
		c0 : in std_logic_vector(7 downto 0);
		c1 : in std_logic_vector(7 downto 0);
		sel: in std_logic;
		z : out std_logic_vector(7 downto 0)
	    );
	end component;
	
	component pc is
		port(        
		endin : in  std_logic_vector(7 downto 0);        
		clk    : in  std_logic;        
		pr, cl : in  std_logic;                
		notrw  : in  std_logic;        
		endout: out std_logic_vector(7 downto 0) 
		);
	end component;
	
signal s_add : std_logic_vector(7 downto 0);
signal s_mux2pc : std_logic_vector(7 downto 0);
signal s_pcatual : std_logic_vector(7 downto 0);
signal s_endpc2mem : std_logic_vector(7 downto 0);
signal s_cout : std_logic;

begin
	u_add : sumpc port map("00000001", s_pcatual, '0', s_cout, s_add);
	u_mux2x8 : mux2x8pc port map(barr, s_add, nbarrinc, s_mux2pc);
	u_pc : pc port map(s_mux2pc, clk, '1', cl, pc_rw, s_pcatual);
	endout <= s_pcatual;
end architecture programcounter;
