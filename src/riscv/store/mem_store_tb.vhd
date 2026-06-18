-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity mem_store_tb is
end;

architecture bench of mem_store_tb is

  component mem_store 
      Port ( 
          ADDR_W     : IN  STD_LOGIC_VECTOR( 1 DOWNTO 0);
          DATA_W     : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
          is_byte    : IN  STD_LOGIC;
          is_half    : IN  STD_LOGIC;
          data_mask  : OUT STD_LOGIC_VECTOR( 3 DOWNTO 0);
          data_value : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
       );
  end component;

  signal ADDR_W: STD_LOGIC_VECTOR( 1 DOWNTO 0);
  signal DATA_W: STD_LOGIC_VECTOR(31 DOWNTO 0);
  signal is_byte: STD_LOGIC;
  signal is_half: STD_LOGIC;
  signal data_mask: STD_LOGIC_VECTOR( 3 DOWNTO 0);
  signal data_value: STD_LOGIC_VECTOR(31 DOWNTO 0) ;

begin

  uut: mem_store port map ( ADDR_W     => ADDR_W,
                            DATA_W     => DATA_W,
                            is_byte    => is_byte,
                            is_half    => is_half,
                            data_mask  => data_mask,
                            data_value => data_value );

  stimulus: process
  begin

    -- Put initialisation code here
    -- Full word

    ADDR_W      <= "00";
    DATA_W      <= x"01020304";
    is_byte     <= '0';
    is_half     <= '0';
    wait for 10 ns;
    assert(data_value = x"01020304") report "Test failed" severity error;
    assert(data_mask  =  "1111"    ) report "Test failed" severity error;

    -- Half word

    ADDR_W      <= "00";
    DATA_W      <= x"01020304";
    is_byte     <= '0';
    is_half     <= '1';
    wait for 10 ns;
    assert(data_value(15 downto 0) = x"0304") report "Test failed" severity error;
    assert(data_mask  =  "0011"    ) report "Test failed" severity error;

    ADDR_W      <= "10";
    DATA_W      <= x"01020304";
    is_byte     <= '0';
    is_half     <= '1';
    wait for 10 ns;
    assert(data_value(31 downto 16) = x"0304") report "Test failed" severity error;
    assert(data_mask  =  "1100"    ) report "Test failed" severity error;

    -- Byte element
    ADDR_W      <= "00";
    DATA_W      <= x"01020304";
    is_byte     <= '1';
    is_half     <= '0';
    wait for 10 ns;
    assert(data_value(7 downto 0) = x"04") report "Test failed" severity error;
    assert(data_mask  =  "0001"    ) report "Test failed" severity error;

    ADDR_W      <= "01";
    DATA_W      <= x"01020304";
    is_byte     <= '1';
    is_half     <= '0';
    wait for 10 ns;
    assert(data_value(15 downto 8) = x"04") report "Test failed" severity error;
    assert(data_mask  =  "0010"    ) report "Test failed" severity error;

    ADDR_W      <= "10";
    DATA_W      <= x"01020304";
    is_byte     <= '1';
    is_half     <= '0';
    wait for 10 ns;
    assert(data_value(23 downto 16) = x"04") report "Test failed" severity error;
    assert(data_mask  =  "0100"    ) report "Test failed" severity error;

    ADDR_W      <= "11";
    DATA_W      <= x"01020304";
    is_byte     <= '1';
    is_half     <= '0';
    wait for 10 ns;
    assert(data_value(31 downto 24) = x"04") report "Test failed" severity error;
    assert(data_mask  =  "1000"    ) report "Test failed" severity error;



    -- Put test bench stimulus code here

    wait;
  end process;


end;
