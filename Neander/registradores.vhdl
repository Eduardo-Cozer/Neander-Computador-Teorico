--COMPONENTES NECESSARIOS PARA OS REGISTRADORES
library ieee;
use ieee.std_logic_1164.all;

entity ffd is
    port(
        d      : in std_logic;
        clk    : in std_logic;
        pr, cl : in std_logic;
        q, nq  : out std_logic
    );
end entity;

architecture latch of ffd is
    	component ffjk is
            port(
		j, k   : in std_logic;
		clk    : in std_logic;
		pr, cl : in std_logic;
		q, nq  : out std_logic
            );
    	end component;

    signal sq  : std_logic := '0';
    signal snq : std_logic := '1';
    signal nj  : std_logic;
begin
    u_td : ffjk port map(d, nj, clk, pr, cl, q, nq);
    nj <= not(d);
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity mux2x1 is
    port(
        c0 : in  std_logic;
        c1 : in  std_logic;
        sel: in  std_logic;
        z  : out std_logic
    );
end entity;

architecture comutar of mux2x1 is 
begin
    z <= (c0 and not(sel)) or (c1 and sel);
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity regCarga1bit is
    port(        
	d0      : in  std_logic;        
	clk0    : in  std_logic;        
	pr0, cl0 : in  std_logic;                
	nrw    : in  std_logic;        
	s      : out std_logic    
    );
end entity;

architecture reg1bit of regCarga1bit is
	component ffd is
	    port(
		d      : in std_logic;
		clk    : in std_logic;
		pr, cl : in std_logic;
		q, nq  : out std_logic
	    );
	end component;
	
	component mux2x1 is
	    port(
		c0 : in  std_logic;
		c1 : in  std_logic;
		sel: in  std_logic;
		z  : out std_logic
	    );
	end component;
	
signal datain, dataout : std_logic;

begin
	unity_ffjkd : ffd port map(datain, clk0, pr0, cl0, dataout);
	unity_mux2x1 : mux2x1 port map(dataout, d0, nrw, datain);
	s <= dataout;
end architecture;

--MODULO ULA
library ieee;
use ieee.std_logic_1164.all;

entity ac is
	port(        
	datain : in  std_logic_vector(7 downto 0);        
	clk    : in  std_logic;        
	pr, cl : in  std_logic;                
	notrw  : in  std_logic;        
	dataout: out std_logic_vector(7 downto 0) 
	);
end entity;

architecture reg8bit of ac is
	component regCarga1bit is
	port(        
	d0      : in  std_logic;        
	clk0    : in  std_logic;        
	pr0, cl0 : in  std_logic;                
	nrw    : in  std_logic;        
	s      : out std_logic    
	);
	end component;

begin
	unity_reg0 : regCarga1bit port map(datain(0), clk, pr, cl, notrw, dataout(0));
	unity_reg1 : regCarga1bit port map(datain(1), clk, pr, cl, notrw, dataout(1));
	unity_reg2 : regCarga1bit port map(datain(2), clk, pr, cl, notrw, dataout(2));
	unity_reg3 : regCarga1bit port map(datain(3), clk, pr, cl, notrw, dataout(3));
	unity_reg4 : regCarga1bit port map(datain(4), clk, pr, cl, notrw, dataout(4));
	unity_reg5 : regCarga1bit port map(datain(5), clk, pr, cl, notrw, dataout(5));
	unity_reg6 : regCarga1bit port map(datain(6), clk, pr, cl, notrw, dataout(6));
	unity_reg7 : regCarga1bit port map(datain(7), clk, pr, cl, notrw, dataout(7));
end architecture reg8bit;

library ieee;
use ieee.std_logic_1164.all;

entity flags is
	port(        
	datain : in  std_logic_vector(1 downto 0);        
	clk    : in  std_logic;        
	pr, cl : in  std_logic;                
	notrw  : in  std_logic;        
	dataout: out std_logic_vector(1 downto 0) 
	);
end entity;

architecture reg8bit of flags is
	component regCarga1bit is
	port(        
	d0      : in  std_logic;        
	clk0    : in  std_logic;        
	pr0, cl0 : in  std_logic;                
	nrw    : in  std_logic;        
	s      : out std_logic    
	);
	end component;

begin
	unity_reg0 : regCarga1bit port map(datain(0), clk, cl, pr, notrw, dataout(0));
	unity_reg1 : regCarga1bit port map(datain(1), clk, pr, cl, notrw, dataout(1));
end architecture reg8bit;

--MODULO MEM
library ieee;
use ieee.std_logic_1164.all;

entity rdm is
	port(        
	datain : in  std_logic_vector(7 downto 0);        
	clk    : in  std_logic;        
	pr, cl : in  std_logic;                
	notrw  : in  std_logic;        
	dataout: out std_logic_vector(7 downto 0) 
	);
end entity;

architecture reg8bit of rdm is
	component regCarga1bit is
	port(        
	d0      : in  std_logic;        
	clk0    : in  std_logic;        
	pr0, cl0 : in  std_logic;                
	nrw    : in  std_logic;        
	s      : out std_logic    
	);
	end component;

begin
	unity_reg0 : regCarga1bit port map(datain(0), clk, pr, cl, notrw, dataout(0));
	unity_reg1 : regCarga1bit port map(datain(1), clk, pr, cl, notrw, dataout(1));
	unity_reg2 : regCarga1bit port map(datain(2), clk, pr, cl, notrw, dataout(2));
	unity_reg3 : regCarga1bit port map(datain(3), clk, pr, cl, notrw, dataout(3));
	unity_reg4 : regCarga1bit port map(datain(4), clk, pr, cl, notrw, dataout(4));
	unity_reg5 : regCarga1bit port map(datain(5), clk, pr, cl, notrw, dataout(5));
	unity_reg6 : regCarga1bit port map(datain(6), clk, pr, cl, notrw, dataout(6));
	unity_reg7 : regCarga1bit port map(datain(7), clk, pr, cl, notrw, dataout(7));
end architecture reg8bit;

library ieee;
use ieee.std_logic_1164.all;

entity remm is
	port(        
	endin : in  std_logic_vector(7 downto 0);        
	clk    : in  std_logic;        
	pr, cl : in  std_logic;                
	notrw  : in  std_logic;        
	endout: out std_logic_vector(7 downto 0) 
	);
end entity;

architecture reg8bit of remm is
	component regCarga1bit is
	port(        
	d0      : in  std_logic;        
	clk0    : in  std_logic;        
	pr0, cl0 : in  std_logic;                
	nrw    : in  std_logic;        
	s      : out std_logic    
	);
	end component;

begin
	unity_reg0 : regCarga1bit port map(endin(0), clk, pr, cl, notrw, endout(0));
	unity_reg1 : regCarga1bit port map(endin(1), clk, pr, cl, notrw, endout(1));
	unity_reg2 : regCarga1bit port map(endin(2), clk, pr, cl, notrw, endout(2));
	unity_reg3 : regCarga1bit port map(endin(3), clk, pr, cl, notrw, endout(3));
	unity_reg4 : regCarga1bit port map(endin(4), clk, pr, cl, notrw, endout(4));
	unity_reg5 : regCarga1bit port map(endin(5), clk, pr, cl, notrw, endout(5));
	unity_reg6 : regCarga1bit port map(endin(6), clk, pr, cl, notrw, endout(6));
	unity_reg7 : regCarga1bit port map(endin(7), clk, pr, cl, notrw, endout(7));
end architecture reg8bit;

--MODULO PC
library ieee;
use ieee.std_logic_1164.all;

entity pc is
	port(        
	endin : in  std_logic_vector(7 downto 0);        
	clk    : in  std_logic;        
	pr, cl : in  std_logic;                
	notrw  : in  std_logic;        
	endout: out std_logic_vector(7 downto 0) 
	);
end entity;

architecture reg8bit of pc is
	component regCarga1bit is
	port(        
	d0      : in  std_logic;        
	clk0    : in  std_logic;        
	pr0, cl0 : in  std_logic;                
	nrw    : in  std_logic;        
	s      : out std_logic    
	);
	end component;

begin
	unity_reg0 : regCarga1bit port map(endin(0), clk, pr, cl, notrw, endout(0));
	unity_reg1 : regCarga1bit port map(endin(1), clk, pr, cl, notrw, endout(1));
	unity_reg2 : regCarga1bit port map(endin(2), clk, pr, cl, notrw, endout(2));
	unity_reg3 : regCarga1bit port map(endin(3), clk, pr, cl, notrw, endout(3));
	unity_reg4 : regCarga1bit port map(endin(4), clk, pr, cl, notrw, endout(4));
	unity_reg5 : regCarga1bit port map(endin(5), clk, pr, cl, notrw, endout(5));
	unity_reg6 : regCarga1bit port map(endin(6), clk, pr, cl, notrw, endout(6));
	unity_reg7 : regCarga1bit port map(endin(7), clk, pr, cl, notrw, endout(7));
end architecture reg8bit;

--MODULO CONTROLE
library ieee;
use ieee.std_logic_1164.all;

entity ri is
	port(        
	instrin : in  std_logic_vector(7 downto 0);        
	clk    : in  std_logic;        
	pr, cl : in  std_logic;                
	notrw  : in  std_logic;        
	instrout: out std_logic_vector(7 downto 0) 
	);
end entity;

architecture reg8bit of ri is
	component regCarga1bit is
	port(        
	d0      : in  std_logic;        
	clk0    : in  std_logic;        
	pr0, cl0 : in  std_logic;                
	nrw    : in  std_logic;        
	s      : out std_logic    
	);
	end component;

begin
	unity_reg0 : regCarga1bit port map(instrin(0), clk, pr, cl, notrw, instrout(0));
	unity_reg1 : regCarga1bit port map(instrin(1), clk, pr, cl, notrw, instrout(1));
	unity_reg2 : regCarga1bit port map(instrin(2), clk, pr, cl, notrw, instrout(2));
	unity_reg3 : regCarga1bit port map(instrin(3), clk, pr, cl, notrw, instrout(3));
	unity_reg4 : regCarga1bit port map(instrin(4), clk, pr, cl, notrw, instrout(4));
	unity_reg5 : regCarga1bit port map(instrin(5), clk, pr, cl, notrw, instrout(5));
	unity_reg6 : regCarga1bit port map(instrin(6), clk, pr, cl, notrw, instrout(6));
	unity_reg7 : regCarga1bit port map(instrin(7), clk, pr, cl, notrw, instrout(7));
end architecture reg8bit;


