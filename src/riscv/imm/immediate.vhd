library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity immediate is
Port ( 
   INSTR    : in  STD_LOGIC_VECTOR (31 downto 0);
   isStore  : in  STD_LOGIC;
   isLoad   : in  STD_LOGIC;
   isbranch : in  STD_LOGIC;
   isJAL    : in  STD_LOGIC;
   isAuipc  : in  STD_LOGIC;
   isLui    : in  STD_LOGIC;
   imm      : out STD_LOGIC_VECTOR (31 downto 0)
 );
end immediate;


architecture arch of immediate is

    function repeat_bit(B: std_logic; N: natural) return std_logic_vector is
        variable result: std_logic_vector(1 to N);
    begin
        for i in 1 to N loop
            result(i) := B;
        end loop;
        return result;
    end;  

    function to_stdl(L: BOOLEAN) return std_ulogic is
    begin
        if L then
            return('1');
        else
            return('0');
        end if;
    end;

   SIGNAL Iimm : STD_LOGIC_VECTOR (31 downto 0);
   SIGNAL Simm : STD_LOGIC_VECTOR (31 downto 0);
   SIGNAL Uimm : STD_LOGIC_VECTOR (31 downto 0);
   SIGNAL Jimm : STD_LOGIC_VECTOR (31 downto 0);
   SIGNAL Bimm : STD_LOGIC_VECTOR (31 downto 0);

begin

   Iimm <= repeat_bit(INSTR(31), 20) & INSTR(31 downto 20);
   Simm <= repeat_bit(INSTR(31), 20) & INSTR(31 downto 25) & INSTR(11 downto 7);
   Uimm <= INSTR(31 downto 12) & x"000";
   Jimm <= repeat_bit(INSTR(31), 12) & INSTR(19 downto 12) & INSTR(20) & INSTR(30 downto 21) & '0';
   Bimm <= repeat_bit(INSTR(31), 20) &  INSTR(7) & INSTR(30 downto 25) & INSTR(11 downto 8) & '0';

   process(all)
   begin
        if isStore = '1' then
            imm <= Simm;
        elsif isbranch = '1' then
            imm <= Bimm;
        elsif isJAL = '1' then 
            imm <= Jimm;
        elsif (isAuipc = '1') or (isLui = '1') then
            imm <= Uimm;
        else 
            imm <= Iimm;
        end if;
    end process;
   
end arch;