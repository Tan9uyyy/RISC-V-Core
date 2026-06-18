library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

USE work.stdio_h.all;

entity observer is
Port (
    clk    : in  STD_LOGIC;
    reset  : in  STD_LOGIC; 
    dat_en : in  STD_LOGIC;
    dat    : in  STD_LOGIC_VECTOR (7 downto 0)
);
end observer;


architecture arch of observer is

    SIGNAL buffer_i  : CHARACTER;
    SIGNAL unique_i  : integer := 0;

begin

    PROCESS(clk)
        variable a : CHARACTER;
    BEGIN
        IF clk'event AND clk = '1' THEN
            IF (RESET = '1') and (unique_i = 0) THEN
                printf("(--)\n");
                printf("(--) RISC-V design framework for teaching\n");
                printf("(--) Bertrand LE GAL 2023-2024\n");
                printf("(--)\n");
                unique_i <= 1;
            ELSIF dat_en = '1' THEN
                a := character'val( TO_INTEGER( UNSIGNED(dat) ) );
                putchar( a );
            END IF;
        END IF;
    END PROCESS;


    PROCESS(clk)
    BEGIN
        IF clk'event AND clk = '1' THEN
            IF dat_en = '1' THEN
                buffer_i <= character'val( TO_INTEGER( UNSIGNED(dat) ) );
            END IF;
        END IF;
    END PROCESS;
   
end arch;
 
