library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity next_pc is
Port ( 
   currPC        : in  STD_LOGIC_VECTOR (31 downto 0);
   decPredict    : in  STD_LOGIC;
   decPrediction : in  STD_LOGIC_VECTOR (31 downto 0);
   exeCorrec     : in  STD_LOGIC;
   exeCorrection : in  STD_LOGIC_VECTOR (31 downto 0);
   pc_to_mem     : out STD_LOGIC_VECTOR (31 downto 0);
   next_pc_value : out STD_LOGIC_VECTOR (31 downto 0)
 );
end next_pc;

architecture arch of next_pc is
   SIGNAL selected_pc : STD_LOGIC_VECTOR (31 downto 0);
begin

    selected_pc <= decPrediction when decPredict  = '1' else -- Prediction faite dans le décodeur
                   exeCorrection when exeCorrec   = '1' else -- Correction provenant de l'étage d'exec
                   currPC;                                   -- La valeur normale du PC

    pc_to_mem     <= selected_pc;
    next_pc_value <= STD_LOGIC_VECTOR( UNSIGNED(selected_pc) + TO_UNSIGNED(4, 32) );
   
end arch;
 
