library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity alu_div is
  PORT (
    clk_i      :  in STD_LOGIC;                       -- the working clock
    rstn_i     :  in STD_LOGIC;                       -- the reset signal
    rs1_i      :  in STD_LOGIC_VECTOR (31 downto 0);  -- first operand
    rs2_i      :  in STD_LOGIC_VECTOR (31 downto 0);  -- second operand
    en_i       :  in STD_LOGIC;                       -- launch computation

    func3_i    :  in STD_LOGIC_VECTOR ( 2 downto 0);  -- the computation to perform
    div_o      : out STD_LOGIC_VECTOR (31 downto 0);  -- the compuation result
    finished_o : out STD_LOGIC;                       -- computation is finished
    busy_o     : out STD_LOGIC                        -- the operator is busy
 );
end alu_div;

architecture arch of alu_div is

  constant op_div_c    : std_logic_vector(2 downto 0) := "100"; -- div
  constant op_divu_c   : std_logic_vector(2 downto 0) := "101"; -- divu
  constant op_rem_c    : std_logic_vector(2 downto 0) := "110"; -- rem
  constant op_remu_c   : std_logic_vector(2 downto 0) := "111"; -- remu

  type state_t is (S_IDLE, S_BUSY, S_DONE);
  SIGNAL state : state_t;

  SIGNAL div_quotient  : STD_LOGIC_VECTOR (31 downto 0);
  SIGNAL div_remainder : STD_LOGIC_VECTOR (31 downto 0);
  SIGNAL div_sub       : STD_LOGIC_VECTOR (32 downto 0);
  SIGNAL rs2_abs       : STD_LOGIC_VECTOR (31 downto 0);
  SIGNAL div_res_u     : STD_LOGIC_VECTOR (31 downto 0);
  SIGNAL div_res       : STD_LOGIC_VECTOR (31 downto 0);

  SIGNAL cnt           : STD_LOGIC_VECTOR (31 downto 0);

  SIGNAL rs1_is_signed : STD_LOGIC;
  SIGNAL rs2_is_signed : STD_LOGIC;
  SIGNAL div_sign_mod  : STD_LOGIC;
    

  function or_reduce_f(input : std_logic_vector) return std_logic is
    variable tmp_v : std_ulogic;
  begin
    tmp_v := '0';
    for i in input'range loop
      tmp_v := tmp_v or input(i);
    end loop;
    return tmp_v;
  end function or_reduce_f;

begin

  -- done? assert one cycle before actual data output --
--finished_o <= '1' when (state = S_DONE)                     else '0';
  busy_o     <=  '1' when (state = S_BUSY) ELSE
                en_i when (state = S_IDLE) ELSE
                 '0';

  --
  -- input operands treated as signed? --
  --
  rs1_is_signed <= '1' when (func3_i = op_div_c)  or (func3_i = op_rem_c) else '0';
  rs2_is_signed <= '1' when (func3_i = op_div_c)  or (func3_i = op_rem_c) else '0';



  control: process(rstn_i, clk_i)
  begin
    if (rstn_i = '0') then
      state        <= S_IDLE;
      rs2_abs      <= (others => '0');
      cnt          <= (others => '0');
      div_sign_mod <= '0';
      finished_o   <= '0';
    elsif rising_edge(clk_i) then
      -- defaults --
      --out_en <= '0';

      -- FSM --
      case state is

        when S_IDLE => -- wait for start signal
          cnt        <= std_logic_vector(to_unsigned(32-2, 32)); -- iterative cycle counter
          finished_o <= '0';
          if (en_i = '1') then -- trigger new operation
          
              -- DIV: check relevant input signs for result sign compensation --
              if ( func3_i(1 downto 0) = op_div_c(1 downto 0) ) then
                -- signed div operation
                 div_sign_mod <= (rs1_i(rs1_i'left) xor rs2_i(rs2_i'left)) and or_reduce_f(rs2_i); -- different signs AND divisor not zero
              
              elsif ( func3_i(1 downto 0) = op_rem_c(1 downto 0)) then
                -- signed rem operation
                div_sign_mod <= rs1_i(rs1_i'left);

              else
                -- unsigned operation
                div_sign_mod <= '0';
              end if;
              
              -- DIV: abs(rs2) --
              if ((rs2_i(rs2_i'left) and rs2_is_signed) = '1') then -- signed division?
                rs2_abs <= std_logic_vector(0 - unsigned(rs2_i)); -- make positive
              else
                rs2_abs <= rs2_i;
              end if;

              state <= S_BUSY;

          end if;

        when S_BUSY => -- processing
          finished_o <= '0';
          cnt        <= std_logic_vector(unsigned(cnt) - 1);
          if or_reduce_f(cnt) = '0' then
            state <= S_DONE;
          end if;

        when S_DONE => -- final step / enable output for one cycle
          finished_o <= '1';
          state      <= S_IDLE;

        when others => -- undefined
          finished_o <= '0';
          state      <= S_IDLE;

      end case;
    end if;
  end process control;


    -- restoring division algorithm --
    divider_core: process(rstn_i, clk_i)
    begin

      if (rstn_i = '0') then

        div_quotient  <= (others => '0');
        div_remainder <= (others => '0');

      elsif rising_edge(clk_i) then

        if ( (en_i = '1') and (state = S_IDLE) ) then -- start new division

          if ((rs1_i(rs1_i'left) and rs1_is_signed) = '1') then -- signed division?

            div_quotient <= std_logic_vector(0 - unsigned(rs1_i)); -- make positive

          else

            div_quotient <= rs1_i;

          end if;

          div_remainder    <= (others => '0');
--        div_remainder(0) <= div_quotient(31);

        elsif (state = S_BUSY) or (state = S_DONE) then -- running?

          div_quotient <= div_quotient(30 downto 0) & (not div_sub(32));

          if (div_sub(32) = '0') then -- implicit shift

            div_remainder <= div_sub(31 downto 0);
--            div_remainder <= div_sub(30 downto 0) & div_quotient(31);

          else -- underflow: restore and explicit shift

            div_remainder <= div_remainder(30 downto 0) & div_quotient(31);

          end if;

        end if;
      end if;
    end process divider_core;

    --
    -- try another subtraction (and shift)
    --
    div_sub <= std_logic_vector(unsigned('0' & div_remainder(30 downto 0) & div_quotient(31)) - unsigned('0' & rs2_abs));

    --
    -- result and sign compensation
    --
    div_res_u <= div_quotient when (func3_i = op_div_c) or (func3_i = op_divu_c) else div_remainder;
    div_res   <= std_logic_vector(0 - unsigned(div_res_u)) when (div_sign_mod = '1') else div_res_u;

    div_o <= div_res;

end arch;
