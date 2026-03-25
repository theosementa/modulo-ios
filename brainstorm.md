# Modulo — Brainstorm & Vision Produit

## Contexte

Modulo est une application iOS native (Swift / SwiftUI + SwiftData, iOS 17+) de suivi d'épargne personnelle.

L'utilisateur définit des **objectifs financiers** (comme des enveloppes) avec un montant cible et une date de fin optionnelle. Il ajoute des **contributions** (dépôts ou retraits) vers ces objectifs. L'app recalcule dynamiquement :
- Le montant mensuel à contribuer pour atteindre l'objectif à temps
- Le temps restant avant la date de fin
- Une courbe de prédiction et une estimation de date de fin potentielle

---

## Features retenues à développer

### 1. Rappels intelligents
Notification mensuelle qui rappelle à l'utilisateur de contribuer, avec le **montant exact recalculé** à la date du rappel.
- Personnalisable : jour du mois, fréquence
- Le contenu de la notification est dynamique (ex: "Il te reste 87€/mois pour atteindre 'Vacances Japon' d'ici août")

### 2. Résumé mensuel
Un écran récapitulatif type "bilan du mois" :
- Total épargné sur le mois
- Objectifs en avance vs. en retard sur leur rythme
- Contributions réalisées ce mois
- Encouragement ou alerte selon la performance

### 3. Nommage libre des contributions
Chaque versement peut avoir un **libellé libre** ("prime de juillet", "argent cadeau", "remboursement Paul").
- Permet de retrouver l'historique facilement
- Visible dans le détail de l'objectif

### 4. Widget iOS
Widget home screen (WidgetKit) affichant les objectifs prioritaires et leur avancement.
- Small : objectif principal + % d'avancement
- Medium : top 2-3 objectifs avec barre de progression
- Mise à jour dynamique selon les dernières contributions

### 5. Mode "Scénarios"
Simuler l'impact d'un retrait ou versement exceptionnel **avant** de le confirmer.
- "Si je retire 200€, ma date de fin passe de mars à juin"
- "Si j'ajoute 500€ ce mois, je suis en avance de 6 semaines"
- Pas de modification réelle des données — simulation pure

---

## Stack technique

- **UI** : SwiftUI
- **Persistence** : SwiftData
- **Notifications** : UserNotifications framework
- **Widgets** : WidgetKit
- **Target** : iOS 17+, Swift 6.2
- **Architecture modulaire** : Modules/Models (Domain, Entities, Enums), Modules/Features, Modules/DesignSystem
