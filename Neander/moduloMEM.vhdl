--COMPONENTES NECESSARIOS
library ieee;
use ieee.std_logic_1164.all;

entity mux2x8 is
    port(
        c0 : in std_logic_vector(7 downto 0);
        c1 : in std_logic_vector(7 downto 0);
        sel: in std_logic;
        z : out std_logic_vector(7 downto 0)
    );
end entity;

architecture comutar of mux2x8 is 

begin
    z <= c0 when sel = '0' else 
         c1 when sel = '1' else 
         "ZZZZZZZZ";
end architecture;

-- neander asynchronous simple ram memory
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.textio.all;

entity as_ram is
	port(
		addr  : in    std_logic_vector(7 downto 0);
		data  : inout std_logic_vector(7 downto 0);
		notrw : in    std_logic;
		reset : in    std_logic
	);
end entity as_ram;

architecture behavior of as_ram is
	type ram_type is array (0 to 255) of std_logic_vector(7 downto 0);
	signal ram : ram_type;
	signal data_out : std_logic_vector(7 downto 0);
begin
	
	rampW : process(notrw, reset, addr, data)
	type binary_file is file of character;
	file load_file : binary_file open read_mode is "neanderram.mem";
	variable char : character;
	begin
		if (reset = '0' and reset'event) then
			-- init ram
			read(load_file, char); -- 0x03 '.'
			read(load_file, char); -- 0x4E 'N'
			read(load_file, char); -- 0x44 'D'
			read(load_file, char); -- 0x52 'R'
			for i in 0 to 255 loop
				if not endfile(load_file) then
					read(load_file, char);
					ram(i) <= std_logic_vector(to_unsigned(character'pos(char),8));
					read(load_file, char);	-- 0x00 orindo de alinhamento 16bits	
				end if; -- if not endfile(load_file) then
			end loop; -- for i in 0 to 255
        	else
		    if (reset = '1' and notrw = '1') then
			    -- Write
			    ram(to_integer(unsigned(addr))) <= data;
		    end if; -- reset == '1'
		end if; -- reset == '0'
	end process rampW;

	data <= data_out when (reset = '1' and notrw = '0')
		  else (others => 'Z');

	rampR : process(notrw, reset, addr, data)
	begin
		if (reset = '1' and notrw = '0') then
				-- Read
				data_out <= ram(to_integer(unsigned(addr)));
		end if; -- reset = '1' and notrw = '0'
	end process rampR;
end architecture behavior;

--OBS: REGISTRADORES ESTAO NO ARQUIVO (registradores.vhdl)

--MODULO MEM
library ieee;
use ieee.std_logic_1164.all;

entity moduloMEM is
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
end entity;

architecture memoria of moduloMEM is

	component mux2x8 is
	    port(
		c0 : in std_logic_vector(7 downto 0);
		c1 : in std_logic_vector(7 downto 0);
		sel: in std_logic;
        	z : out std_logic_vector(7 downto 0)
	    );
	end component;
	
	component remm is
	port(        
		endin : in  std_logic_vector(7 downto 0);        
		clk    : in  std_logic;        
		pr, cl : in  std_logic;                
		notrw  : in  std_logic;        
		endout: out std_logic_vector(7 downto 0) 
		);
	end component;
	
	component as_ram is
	port(
		addr  : in    std_logic_vector(7 downto 0);
		data  : inout std_logic_vector(7 downto 0);
		notrw : in    std_logic;
		reset : in    std_logic
	);
	end component as_ram;

	component rdm is
	port(        
		datain : in  std_logic_vector(7 downto 0);        
		clk    : in  std_logic;        
		pr, cl : in  std_logic;                
		notrw  : in  std_logic;        
		dataout: out std_logic_vector(7 downto 0) 
		);
	end component;
	
	signal s_mux2rem : std_logic_vector(7 downto 0);
	signal s_rem2mem: std_logic_vector(7 downto 0);
	signal s_mem2rdm : std_logic_vector(7 downto 0);
	signal s_rdm2barramento : std_logic_vector(7 downto 0);
	
begin
	u_mux : mux2x8 port map(end_Barr, end_PC, nbarrPC, s_mux2rem);
	u_rem : remm port map(s_mux2rem, clk, '1', rst, REM_nrw, s_rem2mem);
	u_mem : as_ram port map(s_rem2mem, s_mem2rdm, MEM_nrw, rst);
	u_rdm : rdm port map(s_mem2rdm, clk, '1', rst, RDM_nrw, s_rdm2barramento);
	barramento <= s_rdm2barramento when MEM_nrw = '0' else (others => 'Z');--mux2x8z especial
	s_mem2rdm <= barramento when MEM_nrw = '1' else (others => 'Z');--mux2x8z especial
end architecture;
