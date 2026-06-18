library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity registers_pass is
Port ( 
   CLOCK    : in   STD_LOGIC;
   RESET    : in   STD_LOGIC;
   
   e_hold   : IN   STD_LOGIC;

   RS1_id   : IN   STD_LOGIC_VECTOR( 4 DOWNTO 0);
   DATA_rs1 : OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);

   RS2_id   : IN   STD_LOGIC_VECTOR( 4 DOWNTO 0);
   DATA_rs2 : OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);

   RD_id    : IN   STD_LOGIC_VECTOR( 4 DOWNTO 0);
   RD_id_we : IN   STD_LOGIC;
   DATA_rd  : IN   STD_LOGIC_VECTOR(31 DOWNTO 0)
 );
end registers_pass;

architecture arch of registers_pass is

   ---------------------------------------------------------------------------------------------------
   type RegFile is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);

   impure function InitRegisters(RamFileName : in string)
      return RegFile is
         variable RAM : RegFile;
   begin
      for I in RegFile'range loop
         RAM(I) := x"00000000";
      end loop;
      return RAM;
   end function;
   
   SIGNAL registerFile : RegFile := InitRegisters("FAKE_STRING.hex");

   SIGNAL v_rs1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL v_rs2 : STD_LOGIC_VECTOR(31 DOWNTO 0);

   SIGNAL b_RS1_id   : STD_LOGIC_VECTOR( 4 DOWNTO 0);
   SIGNAL b_RS2_id   : STD_LOGIC_VECTOR( 4 DOWNTO 0);
   SIGNAL b_RD_id    : STD_LOGIC_VECTOR( 4 DOWNTO 0);
   SIGNAL b_RD_id_we : STD_LOGIC;
   SIGNAL b_DATA_rd  : STD_LOGIC_VECTOR(31 DOWNTO 0);

begin

   process(CLOCK)
   begin
      if rising_edge(CLOCK) then
         if RESET = '1' then
            DATA_rs1 <= (others => '0');
            DATA_rs2 <= (others => '0');
         elsif e_hold = '0' then
            -- Read RS1 with write-bypass
            if RS1_id = "00000" then
               DATA_rs1 <= (others => '0');
            elsif (RD_id_we = '1') and (RS1_id = RD_id) then
               DATA_rs1 <= DATA_rd;
            else
               DATA_rs1 <= registerFile(to_integer(unsigned(RS1_id)));
            end if;

            -- Read RS2 with write-bypass
            if RS2_id = "00000" then
               DATA_rs2 <= (others => '0');
            elsif (RD_id_we = '1') and (RS2_id = RD_id) then
               DATA_rs2 <= DATA_rd;
            else
               DATA_rs2 <= registerFile(to_integer(unsigned(RS2_id)));
            end if;
         end if;

         -- Write to register file (x0 is never written)
         if (RD_id_we = '1') and (RD_id /= "00000") then
            registerFile(to_integer(unsigned(RD_id))) <= DATA_rd;
         end if;
      end if;
   end process;

end arch;
