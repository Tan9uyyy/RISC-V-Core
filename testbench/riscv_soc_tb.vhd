-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity riscv_soc_tb is
end;

architecture bench of riscv_soc_tb is

  component riscv_soc
    GENERIC(
         uart_tx_en : INTEGER := 1;
         uart_rx_en : INTEGER := 1;
         termial_en : INTEGER := 0
    ); 
  Port ( 
      CLK_12MHz    : in  STD_LOGIC;
      RESET_i      : in  STD_LOGIC;
      LED 		    : out STD_LOGIC_VECTOR (1 downto 0);

      UART_RXD_OUT : out STD_LOGIC;
      UART_TXD_IN  : in  STD_LOGIC;

      led0_b        : out STD_LOGIC;
      led0_g        : out STD_LOGIC;
      led0_r        : out STD_LOGIC;
  
     JA_PMOD_CS    : out STD_LOGIC;
     JA_PMOD_MOSI  : out STD_LOGIC;
     JA_PMOD_SCK   : out STD_LOGIC;
     JA_PMOD_DC    : out STD_LOGIC;
     JA_PMOD_RES   : out STD_LOGIC;
     JA_PMOD_VCCEN : out STD_LOGIC;
     JA_PMOD_EN    : out STD_LOGIC       
  );
  end component;

  signal CLK_12MHz      : STD_LOGIC;
  signal RESET          : STD_LOGIC;
  signal LED            : STD_LOGIC_VECTOR (1 downto 0);
  signal UART_RXD_OUT   : STD_LOGIC ; 

  constant clock_period : time := 10 ns;
  signal stop_the_clock : boolean;

begin


   ------------------------------------------------------------------------------------


   uut: riscv_soc
    GENERIC MAP(
         uart_tx_en => 1,
         uart_rx_en => 0,
         termial_en => 1
    )
    port map (
        CLK_12MHz     => CLK_12MHz,
        RESET_i       => RESET,
        LED           => LED,
        
        UART_RXD_OUT  => UART_RXD_OUT,
        UART_TXD_IN   => '0',

        led0_b        => open,
        led0_g        => open,
        led0_r        => open,
     
        JA_PMOD_CS    => open,
        JA_PMOD_MOSI  => open,
        JA_PMOD_SCK   => open,
        JA_PMOD_DC    => open,
        JA_PMOD_RES   => open,
        JA_PMOD_VCCEN => open,
        JA_PMOD_EN    => open
    );


   ------------------------------------------------------------------------------------


   clocking: process
   begin
      while not stop_the_clock loop
         CLK_12MHz <= '0', '1' after clock_period / 2;
         wait for clock_period;
      end loop;
      wait;
   end process;


   ------------------------------------------------------------------------------------


   stimulus: process
   begin
      -- Put initialisation code here
      RESET <= '1';
      wait for 4 * clock_period;

      RESET <= '0';
      wait for clock_period;

      -- Put test bench stimulus code here

      --stop_the_clock <= true;
      wait;
   end process;

end;
