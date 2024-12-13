# README: Super Pong Bros

## Introduction
Super Pong Bros est une adaptation originale du classique jeu Pong, réalisée dans l'univers de Mario. Codé en **Processing**, ce jeu apporte une touche unique en intégrant des mécaniques de power-ups et des éléments emblématiques de l'univers Mario. Conçu pendant ma deuxième année de prépa, ce jeu se joue à deux en local sur un même ordinateur.

Ce projet a été réalisé en autonomie, pour le plaisir de créer et d'explorer de nouvelles idées. Notez que les conventions de codage classiques n'ont pas toujours été suivies, reflétant son statut de "vieux projet".

## Gameplay

### Règles de Base
- Deux joueurs contrôlent chacun une raquette, située respectivement à gauche et à droite de l'écran.
- Une balle se déplace sur l'écran, et le but est de la renvoyer pour marquer des points.

### Power-Ups
- **Cubes Power-Up** : Des cubes défilent du haut vers le bas au centre de l'écran. Lorsqu'une balle touche un cube, le joueur correspondant récupère un power-up.
- **Champignons Mario** : Certains power-ups font apparaître des champignons, qui octroient des bonus spéciaux lorsqu'ils sont récupérés par un joueur.

### Particularités
- Chaque power-up a un effet unique qui peut influencer la partie (exemple : accélération de la balle, augmentation de la taille de la raquette, etc.).

## Fonctionnalités Clés
- **Mode local à 2 joueurs** : Idéal pour des parties conviviales.
- **Mécaniques dynamiques** : Intégration de power-ups et d'éléments thématiques de Mario.
- **Univers Mario** : Graphismes et sons inspirés de la franchise Super Mario.

## Prérequis Techniques
- **Processing** : Ce jeu est développé avec Processing. Vous devez installer Processing pour exécuter le code.

### Installation
1. Clonez ou téléchargez le repository du projet.
2. Ouvrez le fichier principal (`SuperPongBros.pde`) dans Processing.
3. Lancez le programme.

### Contrôles
- **Joueur 1** : Contrôle sa raquette avec les touches `W` (haut) et `S` (bas).
- **Joueur 2** : Contrôle sa raquette avec les flèches haut et bas.

## Structure du Code
- **pong.pde** : Contient la logique principale du jeu.
- **balle.pde** : Gère la physique et les interactions de la balle.
- **mur.pde** : Définit les obstacles et leurs interactions avec la balle.
- **objet.pde** : Implémente la logique des power-ups généraux.
- **objet_au_sol.pde** : Gère les power-ups spécifiques apparaissant au sol.
- **platforme.pde** : Définit les plateformes et leur comportement.
- **projectile.pde** : Implémente les projectiles déclenchés par certains power-ups.

## Améliorations Futures
- Ajouter un mode solo avec une intelligence artificielle pour l'adversaire.
- Intégrer plus de power-ups pour diversifier les mécaniques de jeu.
- Enrichir les graphismes avec des sprites plus détaillés.

## Remerciements
Ce projet a été réalisé dans le cadre de ma deuxième année de prépa. Merci à l’univers Mario pour l’inspiration et aux outils Processing pour leur simplicité d’utilisation.

---
**Auteur :** Néo Schobert

