# Simulating with GHDL
 
Ce repertoire contient les scripts nécessaire à la simulation des différents éléments de l'architecture à l'aide de l'outil GHDL disponible sous Linux et MacOS.

Differents fichiers **Makefile** vous permettront de lancer la simulation des testbenchs présents dans le repertoire portant le même nom. Pour lancer un simulation, il suffit de taper dans le terminal la commande suivante:

```
make -f ./scripts/Makefile.riscv
```

Par défaut avec le code VHDL initial fourni par votre enseignant vous ne devrier pas voir grand chose à l'écran... Dans votre terminal vous devriez observer le contenu suivant indiquant que la simulation s'est bien lancée et puis c'est tout ;-) 

```
❯ make -f ./scripts/Makefile.riscv
ghdl -a  --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/tools/strings_h.vhdl ../src/tools/regexp_h.vhdl ../src/tools/ctype_h.vhdl ../src/tools/stdlib_h.vhdl ../src/tools/stdio_h.vhdl ../src/riscv_types.vhd ../src/riscv.vhd ../src/riscv_soc.vhd ../src/observer.vhd ../src/mem_rom.vhd ../src/mem_ram.vhd ../src/alu.vhd ../src/decoder.vhd ../src/registers.vhd ../src/immediate.vhd ../src/mem_store.vhd ../src/mem_load.vhd ../src/cnt_cycles.vhd ../src/cnt_instr.vhd ../src/csr_registers.vhd ../src/fetch.vhd ../src/uart_recv.vhd ../src/uart_send.vhd ../testbench/riscv_soc_tb.vhd
ghdl -e --std=08 -frelaxed riscv_soc_tb
ghdl -r --std=08 -frelaxed riscv_soc_tb --stop-time=100000ns --vcd=trace.vcd --ieee-asserts=disable --max-stack-alloc=0
(--)
(--) RISC-V design framework for teaching
(--) Bertrand LE GAL 2023-2024
(--)
```

Toutefois, un fichier contenant la trace de tous les signaux VHDL présents dans l'architecture a été généré. Ce fichier se nomme **trace.vcd** Vous pouvez l'ouvrir avec differents outils.

### GtkWave (Linux)

Cet outil est populaire sous Linux. Il est disponible aussi sous Windows et MacOS, mais peut être pénible à installer... Pour le lancer en lui demandant de charger le fichier contenant les signaux il suffit de taper:

```
gtkwave trace.vcd
```

Pour ceux qui ne l'auraient pas installé sur leur machine, vous pouvez simplement l'obtenir en tapant :

```
sudo apt install gtkwave
```

### GtkWave Scansion (MacOS)

Sous MacOS, la manière la plus agréable d'observer ces même signaux est d'utiliser l'outil **scansion**. C'est un outil commercial qui est devenu gratuit mais qui n'est plus maintenu par ses auteurs.Pour le lancer en lui demandant de charger le fichier contenant les signaux il suffit de taper:

```
/Applications/Scansion.app/Contents/MacOS/Scansion trace.vcd
```

### GtkWave wavetrace (visual code plugin)
Il existe un plugin qui permet à Visual Code d'afficher les signaux contenus dans un fichier VCD. Cette extension gratuite est toutefois limité en termes de nombre de signaux affichables et semble mal fonctionner par exemple sur MacOS.

https://www.wavetrace.io

