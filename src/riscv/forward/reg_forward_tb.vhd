library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity reg_forward_tb is
end reg_forward_tb;

architecture behavior of reg_forward_tb is

    component reg_forward
    Port ( 
       EM_wbEnable         : in  STD_LOGIC;
       MW_wbEnable         : in  STD_LOGIC;
       DE_rs1Id_eq_EM_rdId : in  STD_LOGIC;
       DE_rs1Id_eq_MW_rdId : in  STD_LOGIC;
       DE_rs2Id_eq_EM_rdId : in  STD_LOGIC;
       DE_rs2Id_eq_MW_rdId : in  STD_LOGIC;
       EM_result           : in  STD_LOGIC_VECTOR (31 downto 0);
       WB_data             : in  STD_LOGIC_VECTOR (31 downto 0);
       DE_rs1              : in  STD_LOGIC_VECTOR (31 downto 0);
       DE_rs2              : in  STD_LOGIC_VECTOR (31 downto 0);
       E_rs1               : out STD_LOGIC_VECTOR (31 downto 0);
       E_rs2               : out STD_LOGIC_VECTOR (31 downto 0)
     );
    end component;

    signal EM_wbEnable         : STD_LOGIC := '0';
    signal MW_wbEnable         : STD_LOGIC := '0';
    signal DE_rs1Id_eq_EM_rdId : STD_LOGIC := '0';
    signal DE_rs1Id_eq_MW_rdId : STD_LOGIC := '0';
    signal DE_rs2Id_eq_EM_rdId : STD_LOGIC := '0';
    signal DE_rs2Id_eq_MW_rdId : STD_LOGIC := '0';
    
    signal EM_result           : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal WB_data             : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal DE_rs1              : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal DE_rs2              : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

    signal E_rs1 : STD_LOGIC_VECTOR(31 downto 0);
    signal E_rs2 : STD_LOGIC_VECTOR(31 downto 0);

begin

    UUT: reg_forward port map (
       EM_wbEnable         => EM_wbEnable,
       MW_wbEnable         => MW_wbEnable,
       DE_rs1Id_eq_EM_rdId => DE_rs1Id_eq_EM_rdId,
       DE_rs1Id_eq_MW_rdId => DE_rs1Id_eq_MW_rdId,
       DE_rs2Id_eq_EM_rdId => DE_rs2Id_eq_EM_rdId,
       DE_rs2Id_eq_MW_rdId => DE_rs2Id_eq_MW_rdId,
       EM_result           => EM_result,
       WB_data             => WB_data,
       DE_rs1              => DE_rs1,
       DE_rs2              => DE_rs2,
       E_rs1               => E_rs1,
       E_rs2               => E_rs2
    );

    stim_proc: process
    begin
        DE_rs1    <= x"11111111"; -- Valeur de base lue dans le banc de registres
        DE_rs2    <= x"22222222"; 
        EM_result <= x"EEEEEEEE"; -- Valeur calculée dans l'ALU (la plus récente)
        WB_data   <= x"DDDDDDDD"; -- Valeur lue en RAM (la moins récente)
        wait for 10 ns;

        -- =========================================================
        -- TEST 1 : Aucun aléa (Situation normale)
        -- =========================================================
        report "TEST 1 : Aucun forwarding";
        -- Les autorisations sont a 0, on doit récupérer les valeurs 11.. et 22..
        wait for 10 ns;
        assert (E_rs1 = x"11111111" and E_rs2 = x"22222222") report "Erreur Test 1" severity error;

        -- =========================================================
        -- TEST 2 : Forwarding simple depuis EM pour rs1
        -- =========================================================
        report "TEST 2 : Forwarding EM -> rs1";
        EM_wbEnable <= '1';
        DE_rs1Id_eq_EM_rdId <= '1';
        wait for 10 ns;
        -- rs1 doit maintenant valoir EEEEEEEE
        assert (E_rs1 = x"EEEEEEEE") report "Erreur Test 2" severity error;
        
        -- On remet à zéro pour le prochain test
        EM_wbEnable <= '0';
        DE_rs1Id_eq_EM_rdId <= '0';
        
        -- =========================================================
        -- TEST 3 : Forwarding simple depuis MW pour rs2
        -- =========================================================
        report "TEST 3 : Forwarding MW -> rs2";
        MW_wbEnable <= '1';
        DE_rs2Id_eq_MW_rdId <= '1';
        wait for 10 ns;
        -- rs2 doit maintenant valoir DDDDDDDD
        assert (E_rs2 = x"DDDDDDDD") report "Erreur Test 3" severity error;

        -- =========================================================
        -- TEST 4 : LE PIÈGE ! Priorité absolue sur rs1
        -- =========================================================
        report "TEST 4 : Priorite EM sur MW pour rs1";
        EM_wbEnable <= '1';
        MW_wbEnable <= '1';
        DE_rs1Id_eq_EM_rdId <= '1';
        DE_rs1Id_eq_MW_rdId <= '1';
        wait for 10 ns;
        -- L'étage EM étant plus récent, c'est lui qui doit gagner l'aiguillage !
        assert (E_rs1 = x"EEEEEEEE") report "Erreur Test 4 (Priorite)" severity error;

        -- =========================================================
        -- TEST 5 : Fausse alerte (Les registres correspondent, mais ce n'est pas une écriture)
        -- =========================================================
        report "TEST 5 : Collision ID mais pas de wbEnable";
        EM_wbEnable <= '0'; -- Par exemple, l'instruction précédente est un simple saut (BRANCH)
        wait for 10 ns;
        -- Comme EM_wbEnable est 0, l'étage EM est ignoré. On tombe sur le MW d'avant !
        assert (E_rs1 = x"DDDDDDDD") report "Erreur Test 5" severity error;

        -- Fin de la simulation
        report "=== TOUS LES TESTS SONT PASSES AVEC SUCCES ===";
        wait; 
    end process;

end behavior;