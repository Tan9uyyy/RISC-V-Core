# Conception d'un Cœur Processeur RISC-V en VHDL

Bienvenue sur le dépôt de mon projet de conception d'un processeur basé sur l'architecture du jeu d'instructions (ISA) RISC-V. 

Ce projet a été réalisé dans le cadre du module **Architecture Avancée** de ma formation d'ingénieur à **Grenoble INP - PHELMA** (filière SEOC 2A). Il m'a permis d'approfondir mes connaissances en conception matérielle (hardware design), en développement VHDL et en compréhension fine du fonctionnement interne des microprocesseurs modernes.

## 🎯 Objectif du Projet

L'objectif principal de ce projet était de concevoir, implémenter en VHDL, simuler et valider un cœur de processeur RISC-V fonctionnel (architecture 32 bits RV32I). Le projet inclut également la compilation et l'exécution de programmes réels en langage C sur ce processeur.

Le développement s'est déroulé en plusieurs grandes étapes :
1. Implémentation d'un **cœur séquentiel (non-pipeliné)**.
2. Écriture et adaptation des **bancs de test (testbenches)** pour la simulation.
3. Exécution d'applications C (compilées via GCC RISC-V) sur le simulateur.
4. Utilisation d'une **architecture pipelinée à 5 étages** (fournie) pour laquelle j'ai implémenté la **Forward Unit** afin d'améliorer drastiquement les performances.

---

## 🛠️ Ma Contribution et Implémentation

Pour concevoir ce processeur de bout en bout, j'ai eu l'opportunité de développer et valider les composants essentiels de chaque étage de l'architecture. 

### 1. L'étage FETCH (Récupération des instructions)
*   **PC FETCH** : Logique de détermination de l'adresse de la prochaine instruction à exécuter (Program Counter).
*   **Program ROM** : Interface de lecture de la mémoire programme contenant le code compilé.
*   *Validation* : Écriture/adaptation des testbenches pour le PC Fetch et la ROM.

### 2. L'étage DECODE (Décodage des instructions)
*   **Instruction Decoder** : Analyse de l'instruction pour identifier l'opération (Opcode, funct3, funct7).
*   **Immediate Decoder** : Extraction et formatage des valeurs immédiates intégrées dans les instructions.
*   **Register File** : Création du banc de 32 registres, gérant la lecture des opérandes et l'écriture des résultats.
*   *Validation* : Développement du testbench pour vérifier l'intégrité des opérations sur les registres.

### 3. L'étage EXECUTE (Exécution)
*   **ALU (Arithmetic Logic Unit)** : Le cœur mathématique du processeur. Prise en charge des opérations arithmétiques, logiques et des décalages.
*   **Store Unit** : Préparation des adresses et des données à stocker en mémoire RAM.

### 4. L'étage MEMORY (Accès Mémoire)
*   **Data RAM** : Module gérant la mémoire de données pour les opérations de Load/Store.
*   **Load Unit** : Formatage, adaptation et extension de signe des données lues depuis la mémoire RAM.
*   *Validation* : Mise en place des tests automatisés pour la RAM.

### 5. Gestion de l'architecture pipelinée
*   **Forward Unit** : Implémentation de l'unité de propagation de données (data forwarding) pour résoudre les aléas de données (data hazards) au sein de l'architecture pipelinée à 5 étages.

---

## 🚀 Résultats et Performances

### Cœur RISC-V Séquentiel (Non-pipeliné)
Le cœur de base a été entièrement validé en simulation via `GHDL`. Il exécute avec succès une grande variété de programmes C :
*   Programmes basiques : `1-hello_putc`, `2-hello_putchar`, `3-hello_print`, `4-hello_printf`
*   Calcul et tableaux : `3-vector-add`
*   Rendu "Graphique" (UART) : `5-riscv_logo_uart`
*   **Benchmarks :** Exécution réussie du célèbre benchmark `7-dhrystone`, prouvant la fiabilité et la conformité du processeur face à des codes lourds et complexes.

### Cœur RISC-V Pipeliné (5 Étages)
Afin d'optimiser les performances, le passage vers une **architecture pipelinée (RISCV_5STG)** a été initié. Bien que l'architecture globale ait été fournie, j'ai eu pour mission d'implémenter la **Forward Unit** afin de garantir la cohérence des données dans le pipeline.
*   Les tests initiaux ont validé l'exécution des programmes `hello_putc` et `hello_putchar`.
*   **Gain de performance mesuré :** Une augmentation fulgurante des performances de **372% à 382%** par rapport à la version séquentielle pour un même code, illustrant parfaitement l'intérêt du pipeline et de l'exécution à un cycle d'horloge (CPI $\approx$ 1).

---

## 💻 Technologies et Outils Utilisés

*   **Langages :** VHDL (Conception matérielle), C et Assembleur RISC-V (Logiciel embarqué)
*   **Simulation et Vérification :** GHDL, GTKWave
*   **Chaîne de compilation (Toolchain) :** RISC-V GNU Compiler Toolchain (`riscv64-linux-gnu-gcc`, `ld`, `objdump`)
*   **Automatisation :** Makefile, Bash

---

## 👤 À propos de l'auteur

**Tanguy BOUCHUT**
Étudiant Ingénieur à **Grenoble INP - PHELMA** | Filière SEOC (Systèmes Embarqués et Objets Connectés)

Ce projet m'a passionné car il fait le lien parfait entre le code logiciel de haut niveau (C) et les portes logiques physiques. Concevoir une architecture RISC-V, la simuler, gérer ses registres et enfin y voir s'exécuter avec succès un *Dhrystone benchmark*, a été une expérience très enrichissante pour le futur ingénieur en systèmes embarqués que je suis.

 N'hésitez pas à me contacter ou à parcourir mes autres projets !
