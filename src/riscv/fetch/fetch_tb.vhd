-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity fetch_tb is
end;

architecture bench of fetch_tb is

  component fetch
  Port ( 
     CLK                 : in  STD_LOGIC;
     resetn              : in  STD_LOGIC;
     enable_f            : in  STD_LOGIC;
     enable_m            : in  STD_LOGIC;
     jumpOrBranchAddress : in  STD_LOGIC_VECTOR (31 downto 0);
     jumpOrBranch        : in  STD_LOGIC;
     pc_value            : out STD_LOGIC_VECTOR (31 downto 0)
   );
  end component;

  signal CLK: STD_LOGIC;
  signal resetn: STD_LOGIC;
  signal enable_f: STD_LOGIC;
  signal enable_m: STD_LOGIC;
  signal jumpOrBranchAddress: STD_LOGIC_VECTOR (31 downto 0);
  signal jumpOrBranch: STD_LOGIC;
  signal pc_value: STD_LOGIC_VECTOR (31 downto 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: fetch port map ( CLK                 => CLK,
                        resetn              => resetn,
                        enable_f            => enable_f,
                        enable_m            => enable_m,
                        jumpOrBranchAddress => jumpOrBranchAddress,
                        jumpOrBranch        => jumpOrBranch,
                        pc_value            => pc_value );

  stimulus: process
  begin
    resetn <= '0';
    enable_f <= '0';
    enable_m <= '0';
    jumpOrBranch <= '0';
    jumpOrBranchAddress <= (others => '0');
    wait for clock_period;
    assert pc_value = x"00000000" report "pc_value has to be reset" severity error;

    resetn <= '1';
    enable_f <= '1';
    wait for clock_period;
    assert pc_value = x"00000004" report "pc_value has to be 4" severity error;

    enable_f <= '0';
    enable_m <= '1';
    wait for clock_period;
    assert pc_value = x"00000004" report "pc_value doesn't have to change" severity error;

    enable_m <= '0';
    jumpOrBranch <= '1';
    wait for clock_period;
    assert pc_value = x"00000004" report "pc_value doesn't have to change" severity error;

    enable_m <= '1';
    wait for clock_period;
    assert pc_value = x"00000000" report "pc_value has to jump to 0 (jumpOrBranchAddress" severity error;

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;

