--COMPONENTES NECESSARIOS CICLOS JN E JZ
library ieee;
use ieee.std_logic_1164.all;

entity mux2x11jn is
    port(
    	c0  : in std_logic_vector(10 downto 0); --jn
    	c1  : in std_logic_vector(10 downto 0); --jmp
        sel : in std_logic;
        s : out std_logic_vector(10 downto 0)
    );
end entity;

architecture comutar of mux2x11jn is 

begin
    s <= c0 when sel = '0' else 
         c1 when sel = '1' else
         (others => 'Z');
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity jn is
    port(
        ciclo    : in std_logic_vector(2 downto 0);
       	sjn : out std_logic_vector(10 downto 0)
    );
end entity;

architecture comutar of jn is 

begin
    sjn(10) <= '1';
    sjn(9) <= '1';
    sjn(8 downto 6) <= "000";
    sjn(5) <= not(ciclo(2)) and ciclo(0);
    sjn(4) <= '0';
    sjn(3) <= '0';
    sjn(2) <= not(ciclo(2)) and not(ciclo(1)) and not(ciclo(0));
    sjn(1) <= not(ciclo(2)) and not(ciclo(1)) and ciclo(0);
    sjn(0) <= not(ciclo(2)) and ciclo(1) and not(ciclo(0));  	
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity mux2x11jz is
    port(
    	c0  : in std_logic_vector(10 downto 0); --jz
    	c1  : in std_logic_vector(10 downto 0); --jmp
        sel : in std_logic;
        s : out std_logic_vector(10 downto 0)
    );
end entity;

architecture comutar of mux2x11jz is 

begin
    s <= c0 when sel = '0' else 
         c1 when sel = '1' else
         (others => 'Z');
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity jz is
    port(
        ciclo    : in std_logic_vector(2 downto 0);
        sjz    : out std_logic_vector(10 downto 0)
    );
end entity;

architecture comutar of jz is 

begin
    sjz(10) <= '1';
    sjz(9) <= '1';
    sjz(8 downto 6) <= "000";
    sjz(5) <= not(ciclo(2)) and ciclo(0);
    sjz(4) <= '0';
    sjz(3) <= '0';
    sjz(2) <= not(ciclo(2)) and not(ciclo(1)) and not(ciclo(0));
    sjz(1) <= not(ciclo(2)) and not(ciclo(1)) and ciclo(0);
    sjz(0) <= not(ciclo(2)) and ciclo(1) and not(ciclo(0));
end architecture;

--OBS: O CICLO JMP TAMBEM E UTILIZADO

--CICLOS
library ieee;
use ieee.std_logic_1164.all;

entity ciclonop is
    port(
        ciclo    : in std_logic_vector(2 downto 0);
        snop     : out std_logic_vector(10 downto 0)
    );
end entity;

architecture comutar of ciclonop is 

begin
    snop(10) <= '1';
    snop(9) <= '1';
    snop(8 downto 6) <= "000";
    snop(5) <= not(ciclo(2)) and not(ciclo(1)) and ciclo(0);
    snop(4) <= '0';
    snop(3) <= '0';
    snop(2) <= not(ciclo(2)) and not(ciclo(1)) and not(ciclo(0));
    snop(1) <= not(ciclo(2)) and not(ciclo(1)) and ciclo(0);
    snop(0) <= not(ciclo(2)) and ciclo(1) and not(ciclo(0));
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity ciclosta is
    port(
        ciclo    : in std_logic_vector(2 downto 0);
       	ssta : out std_logic_vector(10 downto 0)
    );
end entity;

architecture comutar of ciclosta is 

begin
    ssta(10) <= '1';
    ssta(9) <= not(ciclo(2)) or ciclo(1) or not(ciclo(0));
    ssta(8 downto 6) <= "000";
    ssta(5) <= not(ciclo(1)) and (ciclo(2) xor ciclo(0));
    ssta(4) <= '0';
    ssta(3) <= ciclo(2) and ciclo(1) and not(ciclo(0));
    ssta(2) <= (not(ciclo(1)) and (ciclo(2) xnor ciclo(0))) or (not(ciclo(2)) and ciclo(1) and ciclo(0));
    ssta(1) <= not(ciclo(1)) and (ciclo(2) xor ciclo(0));
    ssta(0) <= not(ciclo(2)) and ciclo(1) and not(ciclo(0));    	
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity ciclolda is
    port(
        ciclo    : in std_logic_vector(2 downto 0);
       	slda : out std_logic_vector(10 downto 0)
    );
end entity;

architecture comutar of ciclolda is 

begin
    slda(10) <= '1';
    slda(9) <= not(ciclo(2)) or ciclo(1) or not(ciclo(0));
    slda(8 downto 6) <= "000";
    slda(5) <= not(ciclo(1)) and (ciclo(2) xor ciclo(0));
    slda(4) <= ciclo(2) and ciclo(1) and ciclo(0);
    slda(3) <= '0';
    slda(2) <= (not(ciclo(1)) and (ciclo(2) xnor ciclo(0))) or (not(ciclo(2)) and ciclo(1) and ciclo(0));
    slda(1) <= (ciclo(2) and not(ciclo(0))) or (not(ciclo(2)) and not(ciclo(1)) and ciclo(0));
    slda(0) <= not(ciclo(2)) and ciclo(1) and not(ciclo(0)); 	
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity cicloadd is
    port(
        ciclo    : in std_logic_vector(2 downto 0);
       	sadd : out std_logic_vector(10 downto 0)
    );
end entity;

architecture comutar of cicloadd is 

begin
    sadd(10) <= '1';
    sadd(9) <= not(ciclo(2)) or ciclo(1) or not(ciclo(0));
    sadd(8 downto 6) <= "001";
    sadd(5) <= not(ciclo(1)) and (ciclo(2) xor ciclo(0));
    sadd(4) <= ciclo(2) and ciclo(1) and ciclo(0);
    sadd(3) <= '0';
    sadd(2) <= (not(ciclo(1)) and (ciclo(2) xnor ciclo(0))) or (not(ciclo(2)) and ciclo(1) and ciclo(0));
    sadd(1) <= (ciclo(2) and not(ciclo(0))) or (not(ciclo(2)) and not(ciclo(1)) and ciclo(0));
    sadd(0) <= not(ciclo(2)) and ciclo(1) and not(ciclo(0)); 	
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity cicloand is
    port(
        ciclo    : in std_logic_vector(2 downto 0);
       	sand : out std_logic_vector(10 downto 0)
    );
end entity;

architecture comutar of cicloand is 

begin
    sand(10) <= '1';
    sand(9) <= not(ciclo(2)) or ciclo(1) or not(ciclo(0));
    sand(8 downto 6) <= "011";
    sand(5) <= not(ciclo(1)) and (ciclo(2) xor ciclo(0));
    sand(4) <= ciclo(2) and ciclo(1) and ciclo(0);
    sand(3) <= '0';
    sand(2) <= (not(ciclo(1)) and (ciclo(2) xnor ciclo(0))) or (not(ciclo(2)) and ciclo(1) and ciclo(0));
    sand(1) <= (ciclo(2) and not(ciclo(0))) or (not(ciclo(2)) and not(ciclo(1)) and ciclo(0));
    sand(0) <= not(ciclo(2)) and ciclo(1) and not(ciclo(0));	
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity cicloor is
    port(
        ciclo    : in std_logic_vector(2 downto 0);
       	sor : out std_logic_vector(10 downto 0)
    );
end entity;

architecture comutar of cicloor is 

begin
    sor(10) <= '1';
    sor(9) <= not(ciclo(2)) or ciclo(1) or not(ciclo(0));
    sor(8 downto 6) <= "010";
    sor(5) <= not(ciclo(1)) and (ciclo(2) xor ciclo(0));
    sor(4) <= ciclo(2) and ciclo(1) and ciclo(0);
    sor(3) <= '0';
    sor(2) <= (not(ciclo(1)) and (ciclo(2) xnor ciclo(0))) or (not(ciclo(2)) and ciclo(1) and ciclo(0));
    sor(1) <= (ciclo(2) and not(ciclo(0))) or (not(ciclo(2)) and not(ciclo(1)) and ciclo(0));
    sor(0) <= not(ciclo(2)) and ciclo(1) and not(ciclo(0));	
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity ciclonot is
    port(
        ciclo    : in std_logic_vector(2 downto 0);
       	snot : out std_logic_vector(10 downto 0)
    );
end entity;

architecture comutar of ciclonot is 

begin
    snot(10) <= '1';
    snot(9) <= '1';
    snot(8 downto 6) <= "100";
    snot(5) <= not(ciclo(2)) and not(ciclo(1)) and ciclo(0);
    snot(4) <= ciclo(2) and ciclo(1) and ciclo(0);
    snot(3) <= '0';
    snot(2) <= not(ciclo(2)) and not(ciclo(1)) and not(ciclo(0));
    snot(1) <= not(ciclo(2)) and not(ciclo(1)) and ciclo(0);
    snot(0) <= not(ciclo(2)) and ciclo(1) and not(ciclo(0)); 	
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity ciclojmp is
    port(
        ciclo    : in std_logic_vector(2 downto 0);
       	sjmp : out std_logic_vector(10 downto 0)
    );
end entity;

architecture comutar of ciclojmp is 

begin
    sjmp(10) <= not(ciclo(2)) or ciclo(1) or not(ciclo(0));
    sjmp(9) <= '1';
    sjmp(8 downto 6) <= "000";
    sjmp(5) <= not(ciclo(1)) and ciclo(0);
    sjmp(4) <= '0';
    sjmp(3) <= '0';
    sjmp(2) <= not(ciclo(2)) and (ciclo(1) xnor ciclo(0));
    sjmp(1) <= not(ciclo(1)) and (ciclo(2) xor ciclo(0));
    sjmp(0) <= not(ciclo(2)) and ciclo(1) and not(ciclo(0));  	
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity ciclojn is
	port(        
	ciclo : in  std_logic_vector(2 downto 0);               
	n: in std_logic;
	sjn: out std_logic_vector(10 downto 0)
	);
end entity;

architecture jn of ciclojn is
	component jn is
	    port(
		ciclo    : in std_logic_vector(2 downto 0);
	       	sjn : out std_logic_vector(10 downto 0)
	    );
	end component;
	
	component ciclojmp is
	    port(
		ciclo    : in std_logic_vector(2 downto 0);
	       	sjmp : out std_logic_vector(10 downto 0)
	    );
	end component;
	
	component mux2x11jn is
	    port(
	    	c0  : in std_logic_vector(10 downto 0);
	    	c1  : in std_logic_vector(10 downto 0);
		sel : in std_logic;
		s : out std_logic_vector(10 downto 0)
	    );
	end component;
	
signal jn2mux : std_logic_vector(10 downto 0);
signal jmp2mux : std_logic_vector(10 downto 0);

begin
	u_jn : jn port map(ciclo, jn2mux);
	u_jmp : ciclojmp port map(ciclo, jmp2mux);
	u_mux2x11 : mux2x11jn port map(jn2mux, jmp2mux, n, sjn);
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity ciclojz is
	port(        
	ciclo : in  std_logic_vector(2 downto 0);               
	z: in std_logic;
	sjz: out std_logic_vector(10 downto 0)
	);
end entity;

architecture jz of ciclojz is
	component jz is
	    port(
		ciclo    : in std_logic_vector(2 downto 0);
	       	sjz : out std_logic_vector(10 downto 0)
	    );
	end component;
	
	component ciclojmp is
	    port(
		ciclo    : in std_logic_vector(2 downto 0);
	       	sjmp : out std_logic_vector(10 downto 0)
	    );
	end component;
	
	component mux2x11jz is
	    port(
	    	c0  : in std_logic_vector(10 downto 0);
	    	c1  : in std_logic_vector(10 downto 0);
		sel : in std_logic;
		s : out std_logic_vector(10 downto 0)
	    );
	end component;
	
signal jz2mux : std_logic_vector(10 downto 0);
signal jmp2mux : std_logic_vector(10 downto 0);

begin
	u_jz : jz port map(ciclo, jz2mux);
	u_jmp : ciclojmp port map(ciclo, jmp2mux);
	u_mux2x11 : mux2x11jz port map(jz2mux, jmp2mux, z, sjz);
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity ciclohlt is
    port(
        ciclo    : in std_logic_vector(2 downto 0);
       	shlt : out std_logic_vector(10 downto 0)
    );
end entity;

architecture comutar of ciclohlt is 

begin
    shlt(10) <= '0';
    shlt(9) <= '0';
    shlt(8 downto 6) <= "000";
    shlt(5) <= '0';
    shlt(4) <= '0';
    shlt(3) <= '0';
    shlt(2) <= '0';
    shlt(1) <= '0';
    shlt(0) <= '0';  	
end architecture;
