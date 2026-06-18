library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity alu is
Port ( 
   rs1_v             : in  STD_LOGIC_VECTOR (31 downto 0);  -- rs_1 value
   rs2_v             : in  STD_LOGIC_VECTOR (31 downto 0);  -- rs_2 value
   isALUreg          : in  STD_LOGIC;                       -- does computation invole rs_1 and rs_2 ? or imm ?
   isBranch          : in  STD_LOGIC;                       -- branch instruction ?
   isAluSubstraction : in  STD_LOGIC;                       -- function7 field, bit 6
   isCustom          : in  STD_LOGIC;                       -- custom instruction
   func3             : in  STD_LOGIC_VECTOR ( 2 downto 0);  -- funct3 field
   func7             : in  STD_LOGIC_VECTOR ( 6 downto 0);  -- funct7 field
   imm_v             : in  STD_LOGIC_VECTOR (31 downto 0);  -- immediate value

   aluOut_v          : out STD_LOGIC_VECTOR (31 downto 0);  -- result of the ALU computation
   aluPlus_v         : out STD_LOGIC_VECTOR (31 downto 0);  -- result of the adder (rs_1 + (rs_2 or imm)), fast path for address computation
   takeBranch        : out STD_LOGIC
 );
end alu;


architecture arch of alu is

   ---------------------------------------------------------------------------------------------------

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
    
   ---------------------------------------------------------------------------------------------------

   signal operande1 : STD_LOGIC_VECTOR(31 downto 0);
   signal operande2 : STD_LOGIC_VECTOR(31 downto 0);

begin

   operande1 <= rs1_v;
   operande2 <= rs2_v when (isALUreg = '1' or isBranch = '1') else imm_v;

   aluPlus_v <= std_logic_vector(unsigned(operande1) + unsigned(operande2));

   process(operande1, operande2, isAluSubstraction, isBranch, isCustom, func3, aluPlus_v)
   begin
    aluOut_v <= x"00000000";
    takeBranch <= '0';
    if isBranch = '1' then 
        case func3 is
            when "000" => -- BEQ
                if unsigned(operande1) = unsigned(operande2) then 
                    takeBranch <= '1';
                end if;
            when "001" => -- BNE
                if unsigned(operande1) /= unsigned(operande2) then 
                    takeBranch <= '1';
                end if;
            when "101" => -- BGE
                if signed(operande1) >= signed(operande2) then 
                    takeBranch <= '1';
                end if;
            when "111" => -- BGEU
                if unsigned(operande1) >= unsigned(operande2) then 
                    takeBranch <= '1';
                end if;
            when "110" => -- BLTU
                if unsigned(operande1) < unsigned(operande2) then 
                    takeBranch <= '1';
                end if;
            when "100" => -- BLT
                if signed(operande1) < signed(operande2) then 
                    takeBranch <= '1';
                end if;
            when others =>
                null;
        end case;
    else 
        case func3 is
            when "000" => -- ADD or SUB
                if isAluSubstraction = '1' then
                    aluOut_v <= std_logic_vector(unsigned(operande1) - unsigned(operande2));
                else 
                    aluOut_v <= aluPlus_v;
                end if;
            when "001" => -- SLL(i)
                aluOut_v <= std_logic_vector(shift_left(unsigned(operande1), to_integer(unsigned(operande2(4 downto 0)))));
            when "011" => -- SLT(i)U
                if unsigned(operande1) < unsigned(operande2) then
                    aluOut_v <= x"00000001";
                else 
                    aluOut_v <= x"00000000";
                end if;
            when "010" => -- SLT(i)
                if signed(operande1) < signed(operande2) then
                    aluOut_v <= x"00000001";
                else 
                    aluOut_v <= x"00000000";
                end if;
            when "110" => -- OR(i)
                aluOut_v <= operande1 OR operande2;
            when "100" => -- XOR(i)
                aluOut_v <= operande1 XOR operande2;
            when "101" => -- SRL(i) or SRA(i)
                if isAluSubstraction = '1' then
                    aluOut_v <= std_logic_vector(shift_right(signed(operande1), to_integer(unsigned(operande2(4 downto 0)))));
                else 
                    aluOut_v <= std_logic_vector(shift_right(unsigned(operande1), to_integer(unsigned(operande2(4 downto 0)))));
                end if;
            when "111" => -- AND(i)
                aluOut_v <= operande1 AND operande2;
            when others =>
                null;
        end case;
    end if;
    end process;

   
end arch;
 
