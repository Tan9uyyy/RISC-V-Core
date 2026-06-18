# Teaching sequence (RISC-V)

Bienvenue dans cette fabuleuse séquence pédagogique !

Cette aventure va vous occuper **environ 30 heures**. Mais rassurez-vous, vous n’allez pas devoir redévelopper votre cœur de processeur *from scratch* ! Un environnement a déjà été préparé afin d'éviter que vous y passiez **six mois à temps plein**...

# Organisation des répertoires

Si vous observez la structure du répertoire, vous remarquerez que **TOUT est bien structuré**. En effet, les multiples répertoires sont dédiés à des parties spécifiques de la séquence. Vous trouverez ci-dessous une description succincte du rôle de chaque répertoire :

- **doc** : lieu de stockage du pdf de cours et des spécifications RISC-V.
- **fpga** : repertoire utilisé pour réaliser le prototypage sur carte FPGA des coeurs RISC-V.
- **simu** : répertoire utilisé lors des phases de simulation des modules VHDL et des coeurs RISC-V.
- **src** : répertoire contenant l'intégralité des codes sources VHDL sur lesquels vous devez intervenir.
- **asic** : répertoire contenant les fichiers et les scripts permettant de réaliser une synthèse logique ciblant une tehcnologie ASIC.
- **firmware** : répertoire contenant les données binaires du programme à simulateur (cf. répertoire **simu**).
- **modelsim** : répertoire inutile pour l'instant (à virer).
- **soft** : le répertoire contenant les codes sources des programmes en *C* qui pourront/devront être déployés sur votre coeur RISC-V. 
- **testbench** : quelques fichiers VHDL dédié à la simulation du coeur RISC-V et de ses périphériques.

N'ayez pas peur, vous allez découvrir tranquillement tout cela...


# Le framework matériel

Dans le cadre de ce projet, vous allez développer du code VHDL pour proposer une architecture de processeur RISCV. 
Les fichiers à compléter se trouve répertoire **./src**, et tout est catégorisé en grandes fonctionnalités. 
Vous allez notemant trouver toutes les grandes étapes du pipeline, dont vous ne devrez développer que les architectures.
Normalement, avec les testbench fournis, vous devriez avoir suffisament d'information. 

ATTENTION 
Ne développez que les arcitectures matérielles où il est écrit 

```vhd
-- To be continued
```

# Conception de l'architecture matérielle

Déplacez vous dans un premier temps dans le repertoire **src** qui se trouve à la racine du répertoire que vous avez récupéré:

```bash
> cd src
```

Normalement ce répertoire est composé des 4 sous répertoires suivants:

- **riscv** : il contient les fichiers VHDL qui décrivent le coeur du processeur RISC-V
- **soc** : la description des architectures déployées sur FPGA (coeur RISC-V + ses périphériques)
- **IPs** : les fichiers VHDL décrivant les périphériques pouvant être inclus dans les SoC.
- **tools** : des fichiers VHDL utilisée pour simplifier l'écriture des module VHDL utilisés pour la simulation.

Normalement, vous ne devriez intervenir que dans le répertoire **riscv**, vous allez donc rentrer dans ce dernier:

```bash
> cd riscv
```

Par souci de clarté, ce répertoire a également été structuré en sous-répertoires. Le contenu de ces derniers est détaillé ci-dessous :  

### Structure du répertoire  

- **fetch** : contient la définition du module de *fetch* (**à compléter -> FAIT**).  
- **decode** : contient la définition du décodeur d'instructions (**à compléter -> FAIT**).  
- **imm** : contient la définition du décodeur de valeurs immédiates (**à compléter -> FAIT**).  
- **regs** : contient la définition du banc de registres (**à compléter -> FAIT**).  
- **alu** : contient la définition de l'**ALU** (**à compléter -> FAIT**).  
- **load** : contient la définition de l'unité de chargement de données depuis la mémoire **RAM** (**à compléter -> FAIT**).  
- **store** : contient la définition de l'unité de stockage des données dans la mémoire **RAM** (**à compléter -> FAIT**).  
- **rom** : contient la définition de la mémoire programme (**à compléter -> FAIT**).  
- **ram** : contient la définition de la mémoire de données (**à compléter -> FAIT (sauf testbench)**).  
- **csr** : contient la définition des registres **CSR** (**fournie**).  
- **addr_stack** : contient la définition d'un prédicteur de branchement pour le cœur pipeline (**fournie**).  
- **forward** : contient la définition de la *forward unit* pour le cœur pipeline (**à compléter**).  

En plus de ces répertoires, différents fichiers **VHDL** sont également présents ici. Toutefois, nous ne détaillerons que deux d'entre eux. 

- **riscv.vhd** : l'architecture qui associe les composants élémentaires nécessaires pour obtenir un coeur RISC-V executant une instruction tout les 5 cycles d'horloge (**fournie**).
- **riscv_5stg.vhd** : une version améliorée de l'architecture précédente pouvant executer une instruction par cycle d'horloge (**fournie**). *Vous travaillerez sur cette version dans un second temps en fonction de votre avancement*.

Comme vous venez de la comprendre, même si l'architecture du coeur RISC-V vous est founie, les modules élémentaires restent à décrire en VHDL. Pour ce faire, il vous faudra une bonne compréhension de l'ensemble du fonctionnement du coeur...


# Simulation des composants élémentaires

Avant d'imaginer faire fonctionner votre coeur RISC-V sur carte, ou meme en simulation, vous allez devoir valider chacun de vos composants élémentaires. Contrairement à la première promotion de cobaye, oups SNum2 de l'ENSATT de Lannion, vous n'aurez pas a rédiger les testbench. Cela vous évitera bien des soucis et vous fera gagner un temps certain.

Pour simuler le comportement des modules élémentaires, rendez vous dans le répertoire **simu** qui se trouve à la racine du dépot.

```bash
> cd simu
```

Ce repertoire contient un makefile qui agrège les commandes / scripts nécessaire à la simulation des différents éléments de l'architecture à l'aide de l'outil GHDL. Toutefois, si vous avez bien sourcé les scripts au départ, vous avez également accès aux commandes de Modelsim (vcom, vsim...). 
Bref, ces scripts étant intégrés dans un unique makefile, vous pouvez choisir le test à executer en fournissant un parametre à la commande make lors de son invocation. Par exemple, si vous executez:

```bash
> make alu_sim
```

Vous devriez voir dans votre terminal que les commandes suivantes sont invoquées:

```bash=
# Nettoyage des anciens fichiers
find . -name "work-obj08.cf" -delete
find . -name "*.o"           -delete
# Analyse des codes VHDL
ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/riscv_types.vhd
ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/alu/alu_pkg.vhd
ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/alu/alu.vhd
ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/alu/alu_tb.vhd
# Elaboration du modele simulable
ghdl -e --std=08 -frelaxed alu_tb
# Simulation du modele
ghdl -r --std=08 -frelaxed alu_tb --wave=trace.ghw --ieee-asserts=disable --max-stack-alloc=0
```

Les premières commandes servent à éffacer les fichiers temporaires. Les première invocation à GHDL vérifient la synthaxe des fichiers VHDL tandis que les dernieres créent et executent la simulation.

En théorie dans votre terminal, vous ne devriez rien voir d'autre suite à l'invocation de ces commandes. Dans votre cas, comme le module ALU est vide, les assertions présentes dans le testbench se déclenchent provocant des messages d'erreur:

```vhdl=
../src/riscv/alu/alu_tb.vhd:81:5:@10ns:(assertion error): Test failed
../src/riscv/alu/alu_tb.vhd:82:5:@10ns:(assertion error): Test failed
../src/riscv/alu/alu_tb.vhd:89:5:@20ns:(assertion error): Test failed
../src/riscv/alu/alu_tb.vhd:90:5:@20ns:(assertion error): Test failed
../src/riscv/alu/alu_tb.vhd:97:5:@30ns:(assertion error): Test failed
../src/riscv/alu/alu_tb.vhd:98:5:@30ns:(assertion error): Test failed
```
La philosophie étant, pas d'erreurs, pas de message, à terme, ils devraient donc tous disparaitre tel que cela est présenté ci-dessous:

```bash=
❯ make alu_sim
# Nettoyage des anciens fichiers
find . -name "work-obj08.cf" -delete
find . -name "*.o"           -delete
# Analyse des codes VHDL
ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/riscv_types.vhd
ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/alu/alu_pkg.vhd
ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/alu/alu.vhd
ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/alu/alu_tb.vhd
# Elaboration du modele simulable
ghdl -e --std=08 -frelaxed alu_tb
# Simulation du modele
ghdl -r --std=08 -frelaxed alu_tb --wave=trace.ghw --ieee-asserts=disable --max-stack-alloc=0
❯
```

En attendant que vous arrivez à ce stade, sachez que vous avez accès aux commandes suivantes afin de valider vos développements :

- **fetch_sim** : lance le test du module de fetch.
- **decoder_sim** : lance le test du decodeur d'instructions.
- **imm_sim** : lance le test du decodeur d'instructions.
- **alu_sim** : lance le test de l'ALU.
- **load_sim** : lance le test de l'unité d'accès mémoire (load).
- **store_sim** : lance le test de l'unité d'accès mémoire (store).

- **regs_sim** : lance le test du banc de registres (tests not implemented)
- **rom_sim** : lance le test de la mémoire ROM (tests not implemented).
- **ram_sim** : lance le test de la mémoire RAM (tests not implemented).

- **mult_sim** : lance le test du multiplieur utilisé dans l'architecture pipeline.

- **div_sim** : lance le test du diviseur séquentiel utilisé dans l'architecture pipeline.

- **clean** : supprime (tous) les fichiers temporaires.


# Simulation du coeur RISC-V

Dans la partie précédente vous avez vu comment utiliser les scripts mis à votre disposition afin de simuler les modules VHDL élémentaires qui composent votre coeur RISC-V. D'un point de vue plus macroscopique vous pouvez utiliser la commande **make** avec les options suivantes pour simuler l'intégralité du coeur :

- **riscv** : lance la simulation du coeur RISC-V séquentiel.
- **riscv_5stg** : lance la simulation du coeur RISC-V pipeline (à faire **beaucoup** plus tard dans la séquence pédagogique).

Avant de lancer la simulation de votre coeur de RISC-V, vous devez bien faire attention au programe *C* qui va être simulé. En effet, avec les scripts par défaut a chaque fois que vous compilez avec les **makefile** fournis.

Pour debuter, retourner dans le répertoire contenant le premier exemple de test, compiler le programme et revenez:

```bash=
❯ cd ../soft/apps/1-hello_putc
❯ make
❯ cd -
```

Une fois que vous avez fait cela, on peut sereinement lancer la simulation du coeur RISC-V. Pour cela, tapez simplement:

```bash=
❯ make riscv
```

Dans votre terminal, vous devriez observer les messages suivants 

```sh=
ghdl -r --std=08 -frelaxed riscv_soc_tb --ieee-asserts=disable --max-stack-alloc=0 --wave=riscv_soc_tb.ghw
Hello !
simulation finished @875ns
```

On retrouve bien ici le message *"Hello !"* qui avait été spécifié dans le programme en *C*.

⚠️ Si vous n'obtenez rien dans votre terminal, cela signifie que votre cœur **RISC-V** n'a pas réalisé les actions attendues et qu'au moins un de vos modules est défectueux.


Pour changer le programme qui est executé par votre coeur RISC-V, il suffit de compiler un autre applicatif. Par exemple, si vous tapez les commandes suivantes:

```bash=
❯ cd ../soft/apps/5-riscv_logo_uart
❯ make
❯ cd -
```
Et que vous relancez la simulation :

```bash=
❯ make riscv
```

Vous devriez observer la sortie suivante:

```sh=
ghdl -r --std=08 -frelaxed riscv_soc_tb --ieee-asserts=disable --max-stack-alloc=0 --wave=riscv_soc_tb.ghw
              vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
                  vvvvvvvvvvvvvvvvvvvvvvvvvvvv
rrrrrrrrrrrrr       vvvvvvvvvvvvvvvvvvvvvvvvvv
rrrrrrrrrrrrrrrr      vvvvvvvvvvvvvvvvvvvvvvvv
rrrrrrrrrrrrrrrrrr    vvvvvvvvvvvvvvvvvvvvvvvv
rrrrrrrrrrrrrrrrrr    vvvvvvvvvvvvvvvvvvvvvvvv
rrrrrrrrrrrrrrrrrr    vvvvvvvvvvvvvvvvvvvvvvvv
rrrrrrrrrrrrrrrr      vvvvvvvvvvvvvvvvvvvvvv  
rrrrrrrrrrrrr       vvvvvvvvvvvvvvvvvvvvvv    
rr                vvvvvvvvvvvvvvvvvvvvvv      
rr            vvvvvvvvvvvvvvvvvvvvvvvv      rr
rrrr      vvvvvvvvvvvvvvvvvvvvvvvvvv      rrrr
rrrrrr      vvvvvvvvvvvvvvvvvvvvvv      rrrrrr
rrrrrrrr      vvvvvvvvvvvvvvvvvv      rrrrrrrr
rrrrrrrrrr      vvvvvvvvvvvvvv      rrrrrrrrrr
rrrrrrrrrrrr      vvvvvvvvvv      rrrrrrrrrrrr
rrrrrrrrrrrrrr      vvvvvv      rrrrrrrrrrrrrr
rrrrrrrrrrrrrrrr      vv      rrrrrrrrrrrrrrrr
rrrrrrrrrrrrrrrrrr          rrrrrrrrrrrrrrrrrr
rrrrrrrrrrrrrrrrrrrr      rrrrrrrrrrrrrrrrrrrr
rrrrrrrrrrrrrrrrrrrrrr  rrrrrrrrrrrrrrrrrrrrrr
> time : 000076B3
> insn : 000017BC
> time : 30387
> insn : 6076
simulation finished @397625ns
```

Bon, vous avez compris le principe de base. Nous n’allons pas passer en revue toutes les applications d’exemple maintenant.

💡 **À vous de les utiliser à bon escient lorsque le besoin s’en fera sentir !**  


# Expérimentation sur cible FPGA:

Vous avez validé votre cœur **RISC-V** en simulation, ce qui vous a permis de conclure que votre code **VHDL** était fonctionnel.  Cependant, il est possible que le code que vous avez écrit ne soit pas **optimal** et/ou **fonctionnel après synthèse**.

👉 Il est donc essentiel de valider **fonctionnellement** votre cœur **RISC-V** sur cible **FPGA**.

🎯 C'est précisément ce que nous allons réaliser dans cette partie.


# Le framework logiciel 

Nous allons débuter la séquence pédagogique par une analyse de la partie logicielle. Rendez-vous dans le repertoire dédié aux aspects logiciels:

```bash=
> cd ./apps
```

Ce répertoire est composé de trois sous répertoires: **apps**, **libuc** et **tools**. Que vous allez parcourir et découvrir maintenant même si cela vous sera plutot utile dans un seconde temps.


## Convertisseur de fichiers binaires

Nous allons dans un premier temps nous rendre dans le répertoire nommé **tool** et plus spécifiquement dans **firmware_words**. Pour cela, tapez:

```bash=
> cd ./tools/firmware_words
```

Cet outil ne fera pas l’objet d’une étude approfondie, son usage se limitant à la conversion des programmes exécutables au format RISC-V en un format de fichiers compatible avec les descriptions VHDL des mémoires (RAM/ROM). Toutefois, afin de le rendre opérationnel sur votre ordinateur, il est nécessaire de le compiler. Pour ce faire, l’outil **make** doit être invoqué, comme illustré ci-dessous:

```bash
> make
```

Une fois la compilation terminée avec succès, vous disposez désormais d'un des outils essentiels pour programmer votre cœur RISC-V à partir de codes source en *C*.


## Compilation de la bibliotheque "stdlib"

Avant de vous consacrer corps et ame au développement de votre coeur RISC-V nous avons une dernière tache à accomplir. Pour compiler de programme en C et les executer sur votre coeur vous avez besoin d'une bibliotheque définissant les fonctions standard de type **printf**. Rendez vous dans le répertoire nommé **libuc**.

```bash
> cd ../../libuc
```

Ici, il vous suffit d'exécuter la commande **make**, qui prendra en charge l'ensemble du processus nécessaire à la génération d'une bibliothèque statique.

```bash
> make
```

Maintenant que cette étape est terminée, vous pouvez passer aux choses sérieuses : analyser le code assembleur de la première application qui sera exécutée sur votre cœur RISC-V. Pour cela commencer par revenir dans le repertoire **soft**:

```bash
> cd ..
```

## Première application basique

L'ensemble des applications de test développées par votre enseignant se trouve dans le répertoire apps. Vous allez à présent vous déplacer vers le répertoire contenant le premier exemple :

```bash
> cd ./apps/1-hello_putc
```

Vous avez pris l'habitude d'utiliser les **makefile** préparés par votre enseignant; poursuivez dans cette voie sans vous arrêter en si bon chemin:

```bash
> make
```

En principe, les lignes suivantes devraient apparaître dans votre terminal :

```bash=
riscv64-linux-gnu-gcc-12 -march=rv32i -mabi=ilp32 -O2 -DRISCV src/hello.c -c -o obj/hello.o
riscv64-linux-gnu-ld  -o ./bin/hello.elf obj/hello.o -T linker.ld -m elf32lriscv -nostdlib 
riscv64-linux-gnu-objdump -D ./bin/hello.elf > ./asm/hello.elf.asm
../../tools/firmware_words/firmware_words ./bin/hello.elf -ram 0x20000 -max_addr 0x20000 -out hex/PROGROM.mem -from_addr 0x00000 -to_addr 0x0FFFF
   LOAD ELF: ./bin/hello.elf
       max address=65536
../../tools/firmware_words/firmware_words ./bin/hello.elf -ram 0x20000 -max_addr 0x20000 -out hex/DATARAM.mem -from_addr 0x10000 -to_addr 0x1FFFF
   LOAD ELF: ./bin/hello.elf
       max address=65536
cp hex/PROGROM.mem ../../../firmware/PROGROM.mem
cp hex/DATARAM.mem ../../../firmware/DATARAM.mem
```

Vous trouverez ci-dessous une explication synthétique des commandes que vous avez invoquées:

- Ligne 1 : *GCC* est utilisé pour compiler le programme écrit en C (*hello.c*) afin de produire un fichier objet (*hello.o*).
- Ligne 2 : *LD* est employé pour générer l’exécutable (hello.elf) en fonction des directives spécifiées dans le fichier de script d’édition de liens (*linker.ld*).
- Ligne 3 : *OBJDUMP* permet de désassembler le code exécutable (binaire) et de générer un listing assembleur du programme (*./asm/hello.elf.asm*).
- ligne 4 à 9 : *firmware_words*, l'outil que vous avez compilé précédemment génère deux fichiers texte. Ces derniers contiennent le code hexadécimal destiné à l'initialisation des mémoires d'instructions (ROM) et de données (RAM).
- ligne 10 à 11 : la commande *cp* permet de copier les fichiers hexadécimaux dans un répertoire spécifique, afin qu'ils soient ensuite accessibles pour la simulation.

Les fichiers **makefile** présents dans les autres répertoires d'exemple accomplissent tous les mêmes actions. Ce tutorial ne sera toutefois pas repris dans le reste du document.

Dans un premier temps, analysez le fichier **C**, nommé **main.c** dans le répertoire **src** décrivant une application de type **Hello world**.

```cpp    
inline int put_c(int c)
{
   volatile unsigned int* uart_ou = (unsigned int*)0x06000000;
   ( *uart_ou ) = c;                            // on envoie le char
}
//
void start() // no main => start is called BEFORE main. It avoid boot sequence !
{
   put_c('H');
   put_c('e');
   put_c('l');
   put_c('l');
   put_c('o');
   put_c(' ');
   put_c('!');
   put_c('\n');
   asm volatile("ebreak");
}
```

Vous remarquerez que ce code ne correspond que partiellement à un Hello world traditionnel :
- Tout d'abord, la fonction **main** est absente et a été remplacée par une fonction nommée **start**. Cette dernière est la première fonction appelée lors de l'exécution d'un programme et exécute une séquence de démarrage permettant d'effectuer diverses initialisations. Afin de simplifier votre premier programme de test, votre enseignant a choisi de supprimer cette séquence de démarrage. Ainsi, l'exécution de votre programme commencera directement par l'instruction **put_c('H');**.
- La fonction **put_c(value)**, décrite ici, réalise une opération équivalente à **printf("%c", value)**. Elle est redéfinie avec le mot-clé **inline** afin d’éviter la génération d’instructions de branchement dans le code assembleur. Cette fonction exécute une écriture mémoire à l’adresse où est localisé le module UART, chargé de transmettre les données vers l’ordinateur.
- Enfin, la dernière ligne de code, préfixée par le mot-clé **asm**, génère une instruction système de type **ebreak**, permettant d’indiquer au simulateur que l’exécution du programme est terminée. Dans la vraie vie, cette instruction restituerait la main au système d’exploitation afin d’effectuer un appel système.

Afin de mieux comprendre comment le processeur va réaliser les actions définies dans ce programme en C, il est possible d'observer le code assembleur généré par GCC. Pour cela vous pouvez ouvrir le fichier **asm/hello.elf.asm**. Son contenu devrait être équivalent à celui présenté ci-dessous:

```asm=
00000000 <start>:
   0:	060007b7          	lui	a5,0x6000
   4:	04800713          	li	a4,72
   8:	00e7a023          	sw	a4,0(a5) # 6000000 <start+0x6000000>
   c:	06500713          	li	a4,101
  10:	00e7a023          	sw	a4,0(a5)
  14:	06c00713          	li	a4,108
  18:	00e7a023          	sw	a4,0(a5)
  1c:	00e7a023          	sw	a4,0(a5)
  20:	06f00713          	li	a4,111
  24:	00e7a023          	sw	a4,0(a5)
  28:	02000713          	li	a4,32
  2c:	00e7a023          	sw	a4,0(a5)
  30:	02100713          	li	a4,33
  34:	00e7a023          	sw	a4,0(a5)
  38:	00a00713          	li	a4,10
  3c:	00e7a023          	sw	a4,0(a5)
  40:	00100073          	ebreak
  44:	00008067          	ret
```

Dans ce code assembleur, les 32 registres du processeur ne sont pas désignés par les notations x0-x31, mais suivent la convention de nommage définie par l'ABI RISC-V (voir la dernière page du document **riscv-card.pdf**).

La première ligne, dont l’instruction sera placée à l’adresse 0x0 de la mémoire d’instructions, charge dans le registre a5 l’adresse mémoire de l’UART. La seconde ligne charge la valeur 72 (caractère ASCII 'H') dans le registre a4. L’instruction de la troisième ligne (sw) indique que cette valeur est stockée en mémoire et transmise à l’UART. La séquence d’instructions suivante (lignes 5 à 17) reproduit ce même processus pour l’ensemble des caractères à afficher. Enfin, la ligne 18 demande au simulateur d’arrêter son exécution.

Pour exécuter ce premier programme de test, votre cœur RISC-V devra être capable de traiter correctement seulement quatre instructions : *lui*, *li* (*addi*), *sw* et *ebreak*. Les autres programmes de test présents dans le répertoire **apps** nécessiteront, quant à eux, une plus grande diversité d’instructions.

Le dernier point à observer concerne la représentation des données en vue de leur utilisation dans le modèle VHDL simulable. Vous pouvez ouvrir les fichiers **PROGROM.mem** et **DATARAM.mem** dans l'éditeur, ou bien examiner leur contenu à l'aide des commandes suivantes :

```bash
> head -n 20 ./hex/PROGROM.mem
> head -n 10 ./hex/DATARAM.mem
```

Dans le premier fichier, vous retrouvez une représentation hexadécimale des instructions assembleur que le cœur doit exécuter. Ce sont les mêmes valeurs que celles présentes dans le fichier **asm** étudié précédemment. Pour vous exercer, vous pouvez les convertir à l'aide de l'outil proposé [**ici**](https://luplab.gitlab.io/rvcodecjs). Le second fichier contient les valeurs initialement présentes en mémoire RAM lors de l’initialisation du circuit. Pour l’instant, l’ensemble des données est égal à zéro, mais cela évoluera par la suite.


## Généralisation de l'observation
Vous venez d’analyser le contenu du premier répertoire pédagogique, qui contient le premier code **C** que vous exécuterez sur votre cœur **RISC-V**. Dans le répertoire **apps**, vous trouverez d'autres exemples, chacun étant préfixé par un numéro. Ce chiffre correspond (normalement) à l'ordre dans lequel vous les utiliserez.  

### Description des exemples : 

- **1-hello_putc** : Premier exemple réalisant l'équivalent d’un **printf** en n'utilisant que des instructions basiques.  
- **2-hello_putchar** : Variante du précédent, mais avec un appel de fonction, sans utilisation de la pile (*stack*).  
- **3-hello_print** : Implémentation similaire, mais avec des appels de fonction imbriqués et l’usage de la pile.  
- **3-vector-add** : Exemple simple exécutant deux boucles **for** pour initialiser et sommer les éléments d’un tableau.  
- **4-hello_printf** : Version améliorée utilisant la véritable fonction **printf**.  
- **5-riscv_logo_uart** : Exemple affichant le logo **RISC-V** dans un terminal. 
- **6-riscv_logo_oled** : Même exemple, mais affiché sur un écran **OLED** (utilisable uniquement sur **FPGA**).  
- **7-dhrystone** : Benchmark classique mesurant le temps de calcul et la valeur de l’**IPC** du processeur.  
- **8-pi_compute** : Programme calculant les **N** premières décimales de **π** (le nombre de décimales est limité par la quantité de **RAM**).  
- **9-coremark** : Benchmark mesurant la puissance du processeur.  
- **10-bit-reverse** : Programme nécessitant l’ajout d’une instruction dédiée dans votre cœur **RISC-V**.  
- **11-isa_zicond** : Programme de test permettant de valider l'intégration de l'extension **ZiCond**.  
- **12-muldiv_uart** : Exemple mesurant les gains apportés par l’ajout de multiplicateurs et diviseurs matériels, comparés à leur émulation logicielle.  
- **shared** : Ensemble de codes **C** et assembleur nécessaires au bon fonctionnement des exemples ci-dessus (*mal organisés, certains étant inutiles*).  

Toutefois, avant de pouvoir exécuter ces programmes, vous devrez concevoir votre cœur... Rendez-vous dans la section suivante !

## FPGA implementation flows

### ATTENTION : toute la suite n4a malheureusement pas pu être effectuée.

Ce repertoire contient tous les scripts de synthèse logique et de placement routage dont vous allez avoir besoin pour vérifier que votre coeur de processeur RISC-V est réellement fonctionnel. On ne traite ici que de circuits FPGA, pour l'estimation des performances de votre coeurs et de la répartition de la complexité, rendez vous dans le repertoire **asic**.

Afin de vous simplifier la vie, et la mienne, l'ensemble du processus de génération du bitstream a été automatisé via des scripts et/ou des makefiles. Avant d'aller plus loin dans la lecture, vérifier avec votre enseignant le type de carte FPGA dont vous disposez car les composants FPGA, les scripts et le **top module** de l'architecture sont diifférents.

Vous devez normalement avoir à portée de main une des plateformes suivantes:
- Digilent CMOD-A7 board
- Digilent Nexys-A7 board

En fonction de la plateforme mise à votre disposition par votre enseignant, vous devrez choisir l'une des trois sous-sections présentées ci-dessous.


### Digilent CMOD-A7 board

Avant de continuer la procédure décrite ci-dessous:
- Vérifiez que vous avez bien compilé l'application *C* que vous souhaitez exécuter sur la carte **FPGA**, car le code exécutable et les données seront inclus dans le *bitstream*.
- Assurez-vous que votre code fonctionne parfaitement en simulation. Une architecture valide en simulation peut **rarement** ne pas fonctionner sur carte. Une architecture **non fonctionnelle** en simulation ne fonctionnera **jamais** sur carte !

Pour lancer la **synthèse logique** et le **placement-routage** à l'aide de l'outil **Vivado 2023.2** d'**AMD Xilinx**, utilisez la commande suivante :

```sh=
❯ make build_riscv_cmod_a7_2023
```

Si vous avez connecté la carte FPGA à votre ordinateur à l'aide du cordon USB vous pouvez charger le bitstream à l'aide de la commande suivante:

```sh=
❯ make load_riscv_cmod
```

Normalement, le chargement du *bitstream* dans le **FPGA** s'est effectué sans encombre...

🐔 si vous vous sentez perdu, tel une poule ayant trouvé un cure-dent, passez à la section suivante pour apprendre à ouvrir l'interface série (**UART**) sur votre ordinateur.


### Digilent Nexys-A7 board

Avant de continuer la procédure décrite ci-dessous:
- Vérifiez que vous avez bien compilé l'application *C* que vous souhaitez exécuter sur la carte **FPGA**, car le code exécutable et les données seront inclus dans le *bitstream*.
- Assurez-vous que votre code fonctionne parfaitement en simulation. Une architecture valide en simulation peut **rarement** ne pas fonctionner sur carte. Une architecture **non fonctionnelle** en simulation ne fonctionnera **jamais** sur carte !

Pour lancer la **synthèse logique** et le **placement-routage** à l'aide de l'outil **Vivado 2023.2** d'**AMD Xilinx**, utilisez la commande suivante :

```
> make build_riscv_nexys_a7
```

Si vous avez connecté la carte FPGA à votre ordinateur à l'aide du cordon USB vous pouvez charger le bitstream à l'aide de la commande suivante:

```sh=
❯ make load_riscv_nexys
```

Normalement, le chargement du *bitstream* dans le **FPGA** s'est effectué sans encombre...

🐔 si vous vous sentez perdu, tel une poule ayant trouvé un cure-dent, passez à la section suivante pour apprendre à ouvrir l'interface série (**UART**) sur votre ordinateur.

<!-->
### Tang Nano 20k board

Avant de continuer la procédure décrite ci-dessous:
- Vérifiez que vous avez bien compilé l'application *C* que vous souhaitez exécuter sur la carte **FPGA**, car le code exécutable et les données seront inclus dans le *bitstream*
- Ce **FPGA** possède peu de mémoire embarquée. Pour que votre cœur fonctionne correctement, il est indispensable d'avoir compilé votre code avec l'option **48k** :
- Assurez-vous que votre code fonctionne parfaitement en simulation. Une architecture valide en simulation peut **rarement** ne pas fonctionner sur carte. Une architecture **non fonctionnelle** en simulation ne fonctionnera **jamais** sur carte !

Pour lancer la **synthèse logique** et le **placement-routage** à l'aide des l'outils open-source **Yosys** et **NextPnR**, utilisez la commande suivante :

```
> make load_nano20k
```

Normalement, le chargement du *bitstream* dans le **FPGA** s'est effectué sans encombre...

🐔 si vous vous sentez perdu, tel une poule ayant trouvé un cure-dent, passez à la section suivante pour apprendre à ouvrir l'interface série (**UART**) sur votre ordinateur.
-->

# Prototypage sur circuit FPGA

Si vous êtes arrivé ici, cela signifie que vous avez chargé le *bitstream* dans la matrice **FPGA**. En simulation, les messages transmis via la fonction *printf* et ses variantes étaient affichés dans le terminal grâce à du code **VHDL** écrit par votre enseignant. Ici, ces mêmes messages sont envoyés via la liaison **UART** intégrée à la carte de développement. Plus précisément, ces données sont véhiculées à l'aide du **cordon USB**. Pour faire apparaître les messages issus du cœur **RISC-V** sur votre ordinateur, vous allez devoir utiliser l'outil **gtkterm**. 

Dans un terminal, lancez ce dernier à l'aide de la commande suivante :

```
> gtkterm &
```

Normalement, vous devriez voir apparaître une interface graphique équivalente à celle présentée ci-dessous :  

![](https://codimd.math.cnrs.fr/uploads/upload_839963e4ae601d78b64a987696d39419.png)

Afin de voir apparaître les messages, vous devez configurer l'outil de la manière suivante :  

![](https://codimd.math.cnrs.fr/uploads/upload_176286a7fa63f022ce83cada792dc1d2.png)

Une fois cette étape faite, vous pouvez soit:
- Appuier sur le bouton **reset** présent surla carte
- Relancer la procédure de chargement du bitstream

Si tout s'est bien passé, vous devriez obtenir un résultat équivalent à celui présenté ci-dessous (si vous avez compilé le premier programme dans le répertoire **apps**) : 

:::danger
:fire: Exemple fonctionnel gtkterm
:::

Si tel est le cas, vous pouvez sabrer le champagne 🥂, car vous venez de franchir le premier **milestone** de cette séquence pédagogique ! 🎉 

Bon, ne prenez pas trop vite confiance 😏, car le premier exemple pédagogique n'exploite que peu de fonctionnalités du cœur **RISC-V**.

📌 Prenez le temps nécessaire pour déployer les exemples pédagogiques **2 à 9** du répertoire **soft/apps**. Au minimum, vous devez executer les applications suivantes: **dhrystone** et **coremark**.

Une fois que cela est fait, vous pouvez passer à la partie suivante.


# Estimation de la complexité matérielle (FPGA)

Si vous êtes arrivé ici c'est que votre coeur RISC-V est fonctionnel sur FPGA ! Vous allez ici vous intéresser à l'analyse de la complexité matérielle de votre coeur. Dans un premier temps, nous allons réaliser cette analyse à l'aide de l'outil Vivado.


<!-->
# Estimation de la complexité matérielle (ASIC)

Maintenant que vous avez validé votre coeur RISC-V sur cible FPGA, vous allez caractériser ses performances en technologie ASIC.

```javascript=
var s = "JavaScript syntax highlighting";
alert(s);
function $initHighlight(block, cls) {
  try {
    if (cls.search(/\bno\-highlight\b/) != -1)
      return process(block, true, 0x0F) +
             ' class=""';
  } catch (e) {
    /* handle exception */
  }
  for (var i = 0 / 2; i < classes.length; i++) {
    if (checkCondition(classes[i]) === undefined)
      return /\d+[\s/]/g;
  }
}
```

# Optimisations architecturales

Vous avez fait une evéluation de la complexité matétielle de otre coeur RISC-V et avez estimé des performances fréquentielles. Gardez bien ces informations car vous allez maintenant essayer d'améliorer ces caractéristiques.

Pour pouvoir facilement réduire la complexité matérielle est optimisant les traitements suivants :
- gestion des comparaisons
- Gestion des décalages (logiques)
- Gestion de tous les décalages (tous)

📌 Prenez le temps nécessaire pour déployer les exemples Si vous avez besoin d'aide pour identifier ces leviers d'amélioration, parlez en avec votre enseignant.

Il y a surement d'autres parties de votre coeur qui pourraient bénéficier d'optmisations. Cependant, une fois que vous avez traité ces 3 points, vous êtes encouragés à passer à la suite.


# Intégration d'une extension de l'ISA

Maintenant que vous avez réduit la complexité matérielle de votre coeur RISC-V, vous allez améliorer ses performances en proposant et en intégrant votre propre extension à l'ISA RV32I.

Afin de motiver l'intégration d'une nouvelle instruction dans l'ISA de base, rendez vous dans le repertoire **soft/apps/10-bit-reverse** ou vous attend un exemple pédagogique.

Cet exemple met en œuvre une transformation simple : une inversion de la position des bits dans un mot de 32 bits.

🔍 Plus précisément :
- Les bits **0** et **31** sont inversés,
- Tout comme les bits **1** et **30**, etc.

Comme vous le verrez ci dessous à partir des extraits de code source qui vous sont fournis, il existe différentes manière de réaliser cette permutation:

```cpp=
uint32_t reverse_uint32(uint32_t Input) {
    uint32_t Output = 0;

    while(Input) {    // non-zero?
        Output <<= 1;
        Output |= Input & 1;
        Input >>= 1;
    }
    return Output;
}

uint32_t reverse_uint32_v2(uint32_t x)
{
    x = ((x & 0x55555555) <<  1) | ((x & 0xAAAAAAAA) >>  1);
    x = ((x & 0x33333333) <<  2) | ((x & 0xCCCCCCCC) >>  2);
    x = ((x & 0x0F0F0F0F) <<  4) | ((x & 0xF0F0F0F0) >>  4);
    x = ((x & 0x00FF00FF) <<  8) | ((x & 0xFF00FF00) >>  8);
    x = ((x & 0x0000FFFF) << 16) | ((x & 0xFFFF0000) >> 16);
    return x;
}
```

Cette opération intrinsèquement simple d'un point de vue matérielle (permutter des fils) s'avère complexe et chronophage à réaliser sur un coeur de processeur. Pour vous en convaincre, observez le nombre de cycle d'horloge nécessaire pour executer ces fonctions:

```shell=
> cd ./soft/apps/10-bit-reverse
> make
> cd ../../../simu
> make riscv
```

Normalement vous devriez obtenir les résultats ci-dessous à la valeur des *?* près :

```shell=
> resultat : F7B3D591
  - insn   : 169
> resultat : F7B3D591
  - insn   : 45
> resultat : F7B3D591
  - insn   : 28
> resultat : ????????
  - insn   : ?
```

Comme vous pouvez le remarquer, réaliser cette transfomation *simple* sur une donnée, une seule fois, peut s'avérer couteuse en termes de nombre de cycle d'horloge. En effet, en fonction du code *C* que écrit, il faut entre 28 et 169 cycles d'horloge pour pour permuttter les bits.

Afin d'améliorer cela, vous pouvez enrichir votre coeur de processeur d'une extension permetttant de réaliser éfficacement ce calcul. Dans le code écrit en langage *C* vous avez du remarquer cette étrange fonction:

```cpp=
inline int reverse_hardware(const int a)
{
    int res;
    asm(".insn r 0x2F, 0, 0, %[result], %[val_a], %[val_b]"        :[result] "=r" (res)
        :[val_a] "r" (a),
         [val_b] "r" (a));
    return res;
}
```

Cette dernière, qui pour le moment réalise un calcul **non fonctionnel**, permet d'invoquer sur votre cœur de processeur une **instruction spécifique de type R** dont les valeurs sont les suivantes : 

- **Opcode** = `0x2F`
- **funct7** = `0`
- **funct3** = `0`

Comme vous l'avez sûrement compris, l'idée est d'ajouter à votre cœur **RISC-V** une instruction particulière optimisant ce traitement. Le champ **is_custom** de votre décodeur d'instruction est spécialement prévu pour cela ;-)

Modifiez votre coeur RISC-V afin de rendre ce programme totalement fonctionnel. Une fois que vous aurez réalisé cette modification, évaluer le surcout matériel induit par cette nouvelle instruction et concluez sur l'interet de l'approche avant de passer à la partie suivante.


# Intégration de l'extension ZiCond

Vous venez d'intégrer une extension spécifique dans votre coeur RISC-V. Cela permet pour un cout silicium raisonnable d'améliorer les performances du coeur dans des domaines applicatifs spécifiques. Comme cela a été évoqué durant le cours, divierses extensions ont été standardisées.

Dans cette partie, vous allez devoir mettre en œuvre l'extension officielle **ZiCond**, qui permet d'optimiser le traitement des affectations conditionnelles. Cette extension, utilisée nativement par GCC, permet d'éliminer les branchements conditionnels lors de l'affectation conditionnelle de valeurs à des variables comme cela est le cas dans le calcul du PGDC (**apps/11-isa_zicond**).

### Vous trouverez les spécifications de cette extension ici :

> https://github.com/riscvarchive/riscv-zicond/blob/main/zicondops.adoc


### Travail à réaliser :

- **Modifiez** votre cœur **RISC-V** pour le rendre compatible avec cette extension.  
- **Vérifiez** (au moins en simulation) que l'ensemble des programmes de test précédents restent fonctionnels.  
- **Déployez** votre processeur sur carte et **évaluez** l'augmentation de sa complexité matérielle.  

📌 **Note** :  
Pour que les anciens programmes tirent parti de ces nouvelles instructions, vous devez modifier les **Makefile**. Cela est nécessaire afin que **GCC** ait connaissance de cette nouvelle fonctionnalité de votre cœur.


# Amusez vous un peu : le coeur pipeline...

-->


Alert Area
---
:::success
Yes :tada:
:::

:::info
This is a message :mega:
:::

:::warning
Watch out :zap:
:::

:::danger
Oh No! :fire:
:::

