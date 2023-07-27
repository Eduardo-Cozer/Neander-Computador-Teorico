--COMPONENTES NECESSARIOS
library ieee;
use ieee.std_logic_1164.all;

entity not8 is
	port(
	x : in std_logic_vector(7 downto 0);
	snot : out std_logic_vector(7 downto 0)
	);
end not8;

architecture comportamento of not8 is
begin
	snot <= not(x); 
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity and8 is
	port(
	x : in std_logic_vector(7 downto 0);
	y : in std_logic_vector(7 downto 0);
	sand : out std_logic_vector(7 downto 0)
	);
end and8;

architecture comportamento of and8 is
begin
	sand <= x and y; 
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity or8 is
	port(
	x : in std_logic_vector(7 downto 0);
	y : in std_logic_vector(7 downto 0);
	sor : out std_logic_vector(7 downto 0)
	);
end or8;

architecture comportamento of or8 is
begin
	sor <= x or y; 
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity sum is
    port(
        x,y : in std_logic_vector(7 downto 0);
        cin: in std_logic;
        cout: out std_logic;
        sadd: out std_logic_vector(7 downto 0)
    );
end entity;

architecture comutar of sum is 

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

library ieee;
use ieee.std_logic_1164.all;

entity mux5x8 is
    port(
        c0 : in std_logic_vector(7 downto 0);
        c1 : in std_logic_vector(7 downto 0);
        c2 : in std_logic_vector(7 downto 0);
        c3 : in std_logic_vector(7 downto 0);
        c4 : in std_logic_vector(7 downto 0);
        sel: in std_logic_vector(2 downto 0);
        z : out std_logic_vector(7 downto 0)
    );
end entity;

architecture comutar of mux5x8 is 

begin
    z <= c0 when sel = "000" else
         c1 when sel = "001" else 
         c2 when sel = "010" else 
         c3 when sel = "011" else 
         c4 when sel = "100" else 
         "ZZZZZZZZ";
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity decnz is
	port(        
	datain : in std_logic_vector(7 downto 0);
	nz: out std_logic_vector(1 downto 0)        
	);
end entity;

architecture comportamento of decnz is 
begin
	nz(0) <= not(datain(7) or datain(6) or datain(5) or datain(4) or datain(3) or datain(2) or datain(1) or datain(0));
	nz(1) <= datain(7);
end architecture;

--MODULO ULA(PEQUENA)
library ieee;
use ieee.std_logic_1164.all;

entity modulo_ula is
	port(        
	x      : in  std_logic_vector(7 downto 0);            
	y      : in std_logic_vector(7 downto 0);
	ula_op : in std_logic_vector(2 downto 0);
	nz     : out std_logic_vector(1 downto 0);
	s      : out std_logic_vector(7 downto 0)
	);
end entity;

architecture alu of modulo_ula is
	component not8 is
	port(
	x : in std_logic_vector(7 downto 0);
	snot : out std_logic_vector(7 downto 0)
	);
	end component;


	component and8 is
	port(
	x : in std_logic_vector(7 downto 0);
	y : in std_logic_vector(7 downto 0);
	sand : out std_logic_vector(7 downto 0)
	);
	end component;

	component or8 is
	port(
	x : in std_logic_vector(7 downto 0);
	y : in std_logic_vector(7 downto 0);
	sor : out std_logic_vector(7 downto 0)
	);
	end component;

	component sum is
    	port(
        x,y : in std_logic_vector(7 downto 0);
        cin: in std_logic;
        cout: out std_logic;
        sadd: out std_logic_vector(7 downto 0)
    	);
	end component;

	component mux5x8 is
	port(
	c0 : in std_logic_vector(7 downto 0);
	c1 : in std_logic_vector(7 downto 0);
	c2 : in std_logic_vector(7 downto 0);
	c3 : in std_logic_vector(7 downto 0);
	c4 : in std_logic_vector(7 downto 0);
	sel: in std_logic_vector(2 downto 0);
	z : out std_logic_vector(7 downto 0)
	);
	end component;

	component decnz is
	port(        
	datain : in std_logic_vector(7 downto 0);
	nz: out std_logic_vector(1 downto 0)        
	);
	end component;
	
	signal s_resultado : std_logic_vector(7 downto 0);
	signal s_not: std_logic_vector(7 downto 0);
	signal s_and : std_logic_vector(7 downto 0);
	signal s_or : std_logic_vector(7 downto 0);
	signal s_add : std_logic_vector(7 downto 0);
	signal s_cout : std_logic;
	signal s_nz : std_logic_vector(1 downto 0);
	
begin
	u_not : not8 port map(x,s_not);
	u_and : and8 port map(x,y,s_and);
	u_or  : or8 port map(x,y,s_or);
	u_add : sum port map(x,y,'0',s_cout, s_add);
	u_mux : mux5x8 port map(y, s_add, s_or, s_and, s_not, ula_op, s_resultado);
	u_det : decnz port map(s_resultado,nz);
	s <= s_resultado;	
end architecture;
