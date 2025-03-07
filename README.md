# Controle_camera_visca
Ce projet vise à contrôler une caméra Sony EVI-D70P en C++ depuis un PC ou une carte Arduino Mega, en utilisant la communication série et le protocole VISCA. Il inclut une gestion du clavier pour piloter la caméra (Pan/Tilt), la création et l’envoi de commandes série, ainsi qu’un système de compilation basé sur CMake pour faciliter le déploiement sur différentes plateformes.




-----------------------------------------Choisir ses paramètres--------------------------------------------------------

Bonjour, tout  d'abord merci de porter votre intérêt à notre projet. Celui-ci permet de controler les mouvements d'une caméra EVI - D70P.
Vous trouverez ci-dessous les étapes afin de pouvoir utiliser notre logiciel au mieux :


Pour commencer, ouvrez le fichier src/main.cpp :
	-Lors de la déclaration de l'objet Camera, selectionné le numéro de la caméra. Par défaut il est a 1.

  >> Si vous compilez sous PC, selectionnez le numéro de COM où la camera est branché.
	
  >> Si vous compilez sous Arduino, ouvrez le fichier CMakeLists.txt et selectionnez le COM où est branché la carte arduino.

Note : Pour regarder le Port sur lequel vous etes connecté sous Windows, ouvrez le Gestionnaire de périphérique et ensuite ouvrez l'onglet Port(COM et LPT). 

--------------------------------------------------Compiler--------------------------------------------------------------



 >> Ouvrez un terminal et rendez vous dans le dossier Camera à l'endroit où il y a le fichier CMakeLists.txt dans celui-ci.

 >> Si vous souhaitez compiler sur PC, tapez les commandes suivantes :

	-  cmake -G "Unix Makefiles" -D PC_BUILD=ON .
	-  make

 >> Si vous souhaitez compiler sur  Arduino Mega 2560, tapez les commandes suivantes :

	-  cmake -G "Unix Makefiles" -D ARDUINO_BUILD=ON .
	-  make
	-  make upload 

	Note : La dernière commande de la partie Arduino sert à téléverser l'executable sur la carte branchée au port COM

/!\ Ne pas oublier le point à la fin des commandes pour préciser que le fichier CMakeLists.txt est dans le dossier actuel. Si vous etes dans un sous dossier tel que "build", il faut mettre ..

## Auteurs
Ce projet a été réalisé par **GAUDET Pierre**, **BOISSENIN Enzo** et **GIRAUD-CARRIER Ewen** dans le cadre du projet **d'informatique**.








