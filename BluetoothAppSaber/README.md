# flutter

Le premier dossier de ce projet « lib » contenant l’ensemble des fichiers de type “.dart”. Ce dossier contient les fichiers indispensables à la conception de l’application, ceux qui contiennent le code de type dart9. Par défaut, le dossier contient le fichier « main.dart » étant ainsi le point d’entrée de l’application faisant appel à de nombreuses autres fonctions. Ces fichiers sont ceux sur lesquels le concepteur de l’application ajoute et/ou modifie le programme pour pouvoir intégrer les fonctionnalités de l’application voulues.

	D’autre part, nous avons les différents fichiers regroupant d’autres fonctions de l’application. Ces fichiers sont également indispensable mais ne sont pas modifiés directement par le concepteur, ils le sont de manière automatique lors de l’ajout de bibliothèque et de fichiers.

	Le 2ème dossier est le dossier « build » contient le code compilé de l’application Flutter10. Le contenu de ce dossier est automatiquement généré lors de la création du projet, il ne nécessite pas de modification manuelle des fichiers qui le constitue.

	Le dossier « android » contient les dossiers et les fichiers permettant d’exécuter l’application sur un système d’exploitation Android1. Ce dossier contient un projet d’application natif16 Android1 et est utilisé lors de la création de l’application Flutter10 pour Android1. Le code Flutter10/Dart9 est compilé puis injecté dans ce projet Android1. De cette manière le résultat est une application native16. Ces dossiers et fichiers sont générés automatiquement lors de la création du projet initial. Ce fichier sera utilisé au cours de ce stage pour l’utilisation de l’application sur Android1.

	Le dossier “ios” contient un projet natif16 XCode iOS15 qui est utilisé lors de la création de votre application Flutter10 pour iOS15. Il est utilisé de la même manière que le projet contenu dans le dossier android est utilisé lors de la création pour Android1.

Parmi ces dossiers, de nombreux fichiers sont également inclus dans le projet:

    • Le fichier .gitignore se trouvant par défaut dans le projet. Il s’agit d’un fichier texte contenant une liste de fichiers, d’extensions de fichiers et de dossiers, devant être ignorés lorsque l’on travaille avec Git. Git est un système de contrôle permettant de suivre les modifications du code source d’un projet de développement logiciel.

    • Le fichier .metadata géré automatiquement par Flutter10 est utilisé pour suivre les propriétés du projet Flutter10. Ce fichier n’est modifié que par Flutter10, il n'est donc pas nécessaire de le modifier manuellement.

    • Le fichier .packages contient du contenu généré automatiquement par le SDK23 Flutter10 et est utilisé pour contenir une liste de dépendances pour le projet Flutter10.

      

    • Le fichier “pubspec.yaml” est le fichier de configuration du projet contenant des paramètres généraux tels que le nom, la description, la version du projet, les dépendances du projet mais également les actifs(assets) comme les images par exemple.
