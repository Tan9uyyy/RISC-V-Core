library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

ENTITY alu_mult IS
  PORT (
    clk_i      :  in STD_LOGIC;
    rstn_i     :  in STD_LOGIC;

    rs1_i      :  in STD_LOGIC_VECTOR (31 downto 0);
    rs2_i      :  in STD_LOGIC_VECTOR (31 downto 0);
    en_i       :  in STD_LOGIC;

    func3_i    :  in STD_LOGIC_VECTOR ( 2 downto 0);
    mul_o      : out STD_LOGIC_VECTOR (31 downto 0);
    finished_o : out STD_LOGIC;
    busy_o     : out STD_LOGIC
 );
END alu_mult;

architecture arch of alu_mult is

  SIGNAL done         : STD_LOGIC;

  SIGNAL is_MULH      : STD_LOGIC;
  SIGNAL is_MULHSU    : STD_LOGIC;

  SIGNAL mul_sign1    : STD_LOGIC;
  SIGNAL mul_sign2    : STD_LOGIC;

  SIGNAL mul_signed1  : STD_LOGIC_VECTOR (32 downto 0);
  SIGNAL mul_signed2  : STD_LOGIC_VECTOR (32 downto 0);
  SIGNAL multiply     : STD_LOGIC_VECTOR (65 downto 0);
    
begin

  is_MULH      <= '0' when func3_i(1 downto 0) = "00" else '1'; -- 32b de poids forts
  is_MULHSU    <= func3_i(1); -- mode signé

  mul_sign1    <= rs1_i(31) and (is_MULH             );
  mul_sign2    <= rs2_i(31) and (is_MULH or is_MULHSU);

  mul_signed1  <= mul_sign1 & rs1_i;
  mul_signed2  <= mul_sign2 & rs2_i;

  process(clk_i)
  begin   
    if rising_edge(clk_i) then
      multiply <= STD_LOGIC_VECTOR( SIGNED(mul_signed1) * SIGNED(mul_signed2) );
      done     <= en_i and (NOT done);
    end if;
  end process;

  mul_o <= multiply(31 downto  0) when is_MULH = '0' else  -- 0 : MUL
           multiply(63 downto 32);                         -- 1 : MH, 2 : MHSU, 3 : MHU
  busy_o     <= en_i and (NOT done);
  finished_o <= done;

end arch;
 
