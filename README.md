# 🗳️ FiveM Vote System (Top-Serveur)

Un système de vote performant et entièrement configurable pour votre serveur FiveM. Ce script permet à vos joueurs de voter pour le serveur sur **Top-Serveur** et de recevoir des récompenses automatiques en jeu.

## ✨ Caractéristiques

* **Liaison Top-Serveur** : Vérification automatique via l'API.
* **Système de Récompenses** : Entièrement configurable (Argent propre/sale, items, véhicules, etc.).
* **Open Source** : Modifiez le code selon vos besoins.
* **Optimisé** : Consommation minimale des ressources du serveur (0.00ms au repos).
* **Logs Discord** : Suivez qui vote et quelles récompenses sont distribuées.

## 🚀 Installation

1. **Téléchargement** :
   Glissez le dossier `vote-system` dans votre dossier `resources` de votre serveur.

2. **Configuration** :
   Ouvrez le fichier `config.lua` pour configurer vos paramètres :
   * Ajoutez votre **Clé API Top-Serveur**.
   * Définissez les récompenses (ex: `1000$`, `1x Pain`).
   * Configurez votre **Webhook Discord** pour les logs.

3. **Démarrage** :
   Ajoutez la ligne suivante à votre fichier `server.cfg` :
   ```cfg
   ensure vote-system
