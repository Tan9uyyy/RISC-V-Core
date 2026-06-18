# ENSSAT-SNum2-RISC-V-design
## Software directory

Ce repertoire contient 3 sous repertoires:

* apps  : des codes sources écrits en C
* libs  : des biblothèques custom qui redefinissent par exemple la fonction printf
* tools : quelques outils nécessaire à la conversion des programmes elf => vhdl

## Avant d'aller plus loin...

Nous allons dans un premier temps, compiler l'outil qui va permettre de generer le contenu des mémoires programme et données à partir des execubales au format elf.

Pour cela vous allez taper les commandes suivantes:

```bash
$ cd tools
$ cd firmware_words
$ make
$ cd ..
$ cd ..
```

## Explorons les codes logiciels

Pour commencer, rendez vous dans le repertoire "1-hello". Pour cela, tapez les commandes :

```bash
$ cd apps
$ cd 1-hello
```

Vous pouvez observer le fichier source minimaliste qui réalise ce affiche ce premier message "hello". Ce dernier se situe dans le repertoire **src**.

* Essayer de comprendre ce que fait ce programme en faisant le lien avec ce que vous avez fait en micocontroleur en 1ere année.

Une fois que vous avez réalliser cela vous pouvez compiler ce programme C afin d'obtenir un executable. Pour cela tapez simplement la commande suivante:

```bash
make
```

Cette commande execute de manière ordonnée les commandes présentes dans le fichier Makefile (que vous pouvez ouvrir et regarder). La séquence de commandes qui s'est executée à produit:

* **bin/hello.elf** : c'est le programme executable executant la description C.
* **asm/hello.asm** : c'est la version desassemblée du programme executable.
* **hex/*.elf**     : ce sont les fichiers qui seront chargés dans les mémoire data et instruction de votre architecture VHDL.

Prenez un peu de temps pour analyser le fichier **hello.asm** afin de comprendre ce que votre compilateur à générer. Au besoin faites vous aider par votre enseignant.

Faite de même avec les fichiers ***.mem** car vous allez les retrouver bientot dans vos modules VHDL ;-)


## Augmentons un peu la difficultée

Ce permier exemple est volontairement tres trivial car il vous servira à valider votre premiere version du processeur. Comme vous avez pu le constater, il n'y a pas de sauts conditionnels ou non. Un programme réaliste avec des appels de fonction est toujours un peu plus complexe !

Déplacez vous dans le repertoire suivant:

```bash
$ cd ..
$ cd 1-hello_world
```

Faites les même étapes que dans la section précédente et analysez le contenu des fichiers ***.asm** et ***.mem**. Cela vous permettra de mieux percevoir à quoi ressemble un programme réel.

Ce second exemple, plus complet vous serira dans un second temps à valider la majorités des instructions processeur que vous devez intégrer.


## Augmentons encore un peu...



## Conclusion
