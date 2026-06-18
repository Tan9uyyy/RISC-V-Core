# FPGA implementation flows

Ce repertoire contient tous les scripts de synthèse logique et de placement routage dont vous allez avoir besoin pour vérifier que votre coeur de processeur RISC-V est réellement fonctionnel. On ne traite ici que de circuits FPGA, pour l'estimation des performances de votre coeurs et de la répartition de la complexité, rendez vous dans le repertoire **asic**.

Afin de vous simplifier la vie, et la mienne, l'ensemble du processus de génération du bitstream a été automatisé via des scripts et/ou des makefiles. Avant d'aller plus loin dans la lecture, vérifier avec votre enseignant le type de carte FPGA dont vous disposez car les composants FPGA, les scripts et le **top module** de l'architecture sont diifférents.

Vous devez normalement avoir à portée de main une des 3 plateformes suivantes:
- Digilent CMOD-A7 board
- Digilent Nexys-A7 board
- Tang Nano 20k board

## Digilent CMOD-A7 board

Avant de continuer la procédure décrite ci-dessous:
- vérifier que vous avez bien compilé l'application C que vous souhaitez voir executé sur la carte FPGA car le code executable et les données seront inclues dans le bitstream.
- vérifier que votre code fonctionne parfaitement en simulation. Une architecture valide en simulation peut (rarement) ne pas fonctionner sur carte. Une architecture non fonctionnelle en simulation, ne fonctionnera pas sur carte, même pas rarement !


## Digilent Nexys-A7 board

Avant de continuer la procédure décrite ci-dessous:
- vérifier que vous avez bien compilé l'application C que vous souhaitez voir executé sur la carte FPGA car le code executable et les données seront inclues dans le bitstream.
- vérifier que votre code fonctionne parfaitement en simulation. Une architecture valide en simulation peut (rarement) ne pas fonctionner sur carte. Une architecture non fonctionnelle en simulation, ne fonctionnera pas sur carte, même pas rarement !


## Tang Nano 20k board

Avant de continuer la procédure décrite ci-dessous:
- vérifiez que vous avez bien compilé l'application *C* que vous souhaitez voir executé sur la carte FPGA car le code executable et les données seront inclues dans le bitstream. Ce FPGA possède peu de mémoire embarquée, pour que votre coeur fonctionne correctement, il est indispensable que vous ayez compilé votre code avec l'option **48k** :

```
> make build_nano20k
```

- vérifiez que votre code fonctionne parfaitement en simulation. Une architecture valide en simulation peut (rarement) ne pas fonctionner sur carte. Une architecture non fonctionnelle en simulation, ne fonctionnera pas sur carte, même pas rarement !

```
> make load_nano20k
```
