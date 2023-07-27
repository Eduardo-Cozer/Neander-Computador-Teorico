library IEEE;
use IEEE.std_logic_1164.all;

entity neander is
	port(
            rst, clk    : in std_logic
        );
end entity;

architecture boss of neander is

    component moduloULA is
	    port(
            rst, clk    : in    std_logic;
            AC_nrw      : in    std_logic;
            ula_op      : in    std_logic_vector(2 downto 0);
            MEM_nrw     : in    std_logic;
            flags_nz    : out   std_logic_vector(1 downto 0);
	    barramento  : inout std_logic_vector(7 downto 0)
	    );
    end component;
    
    component moduloMEM is
	    port(
            rst, clk   : in    std_logic;
            nbarrPC    : in    std_logic;
            REM_nrw    : in    std_logic;
            MEM_nrw    : in    std_logic;
            RDM_nrw    : in    std_logic;
            end_PC     : in    std_logic_vector(7 downto 0);       
            end_Barr   : in    std_logic_vector(7 downto 0);
            barramento : inout std_logic_vector(7 downto 0)
	    );
    end component;
    
    component modulouc is
	    port(
		barramento  : in  std_logic_vector(7 downto 0);
		enz    : in std_logic_vector(1 downto 0);
		cl, clk : in std_logic;
		rinrw  : in std_logic;
		sctrl : out std_logic_vector(10 downto 0)
		);
    end component;
    
    component modulopc is
		port(        
		barr : in  std_logic_vector(7 downto 0);        
		clk  : in  std_logic;        
		cl   : in  std_logic;                
		nbarrinc  : in  std_logic;    
		pc_rw  : in  std_logic;        
		endout: out std_logic_vector(7 downto 0) 
		);
    end component;

    signal sbarramento : std_logic_vector(7 downto 0) := (others => '0');
    signal sbarramentocontrole : std_logic_vector(10 downto 0) := (others => '0');
    signal flags2uc : std_logic_vector(1 downto 0);
    signal spc2endpc : std_logic_vector(7 downto 0);

begin
    superula : moduloULA port map(rst, clk, sbarramentocontrole(4), sbarramentocontrole(8 downto 6), sbarramentocontrole(3), flags2uc, sbarramento);

    supermem : moduloMEM port map(rst, clk, sbarramentocontrole(9), sbarramentocontrole(2), sbarramentocontrole(3), sbarramentocontrole(1), spc2endpc, sbarramento, sbarramento);
    
    superuc : modulouc port map(sbarramento, flags2uc, rst, clk, sbarramentocontrole(0), sbarramentocontrole);
    
    superpc : modulopc port map(sbarramento, clk, rst, sbarramentocontrole(10), sbarramentocontrole(5), spc2endpc);

end architecture;
