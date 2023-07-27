--COMPONENTES NECESSARIOS

--OBS: A PEQUENA ULA ESTA NO ARQUIVO(pequenaULA.vhdl)
--OBS: REGISTRADORES ESTAO NO ARQUIVO (registradores.vhdl)

--MODULO ULA
library ieee;
use ieee.std_logic_1164.all;

entity moduloULA is
	    port(
            rst, clk    : in    std_logic;
            AC_nrw      : in    std_logic;
            ula_op      : in    std_logic_vector(2 downto 0);
            MEM_nrw     : in    std_logic;
            flags_nz    : out   std_logic_vector(1 downto 0);
            barramento  : inout std_logic_vector(7 downto 0)
	    );
end entity;

architecture lula of moduloULA is
	
	component ac is
	port(        
	datain : in  std_logic_vector(7 downto 0);        
	clk    : in  std_logic;        
	pr, cl : in  std_logic;                
	notrw  : in  std_logic;        
	dataout: out std_logic_vector(7 downto 0) 
	);
	end component;
	
	component modulo_ula is
	port(        
	x      : in  std_logic_vector(7 downto 0);            
	y      : in std_logic_vector(7 downto 0);
	ula_op : in std_logic_vector(2 downto 0);
	nz     : out std_logic_vector(1 downto 0);
	s      : out std_logic_vector(7 downto 0)
	);
	end component;

	component flags is
	port(        
	datain : in  std_logic_vector(1 downto 0);        
	clk    : in  std_logic;        
	pr, cl : in  std_logic;                
	notrw  : in  std_logic;        
	dataout: out std_logic_vector(1 downto 0) 
	);
	end component;
	
	signal s_ac2ula : std_logic_vector(7 downto 0);
	signal s_ula2ac : std_logic_vector(7 downto 0);
	signal s_ac2flags : std_logic_vector(1 downto 0);
begin	
	u_regac : ac port map(s_ula2ac, clk, '1', rst, AC_nrw, s_ac2ula);
	u_littleula : modulo_ula port map(s_ac2ula, barramento, ula_op, s_ac2flags, s_ula2ac);
	u_regflags : flags port map(s_ac2flags, clk, '1', rst, AC_nrw, flags_nz);
	barramento <= s_ac2ula when MEM_nrw='1' else (others => 'Z');--mux2x8z especial
end architecture;
