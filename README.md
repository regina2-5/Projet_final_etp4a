# SkillLink — Prototype Frontend

Maquette cliquable en HTML/CSS/JS statique.

## Structure

```
skilllink-frontend/
├── index.html              # Page d'accueil (à venir)
├── pages/                  # Une page HTML par écran du parcours utilisateur
├── css/
│   ├── reset.css            # Reset minimal
│   ├── tokens.css           # Couleurs, typographie, espacements (source de vérité)
│   ├── layout.css           # Header, footer, boutons, structure partagée
│   └── components.css       # Cartes, formulaires, badges de rôle, tags
├── js/
│   └── main.js               # Comportements partagés (nav mobile, etc.)
└── assets/img/              # Visuels
```

Chaque page HTML inclut les 4 fichiers CSS dans cet ordre :
`reset.css` → `tokens.css` → `layout.css` → `components.css`,
puis un fichier CSS propre à la page si nécessaire (ex. `pages/offres.css`).

## Design system (résumé)

- **Couleurs** : bleu nuit `#14213D` (confiance), fond crème `#F7F5F0`,
  accent ambre `#E8A33D` (opportunité/CTA). Chaque rôle a sa couleur :
  Étudiant = sarcelle, Entreprise = terre cuite, Formateur = prune.
- **Typo** : Fraunces (titres) + Inter (texte) + IBM Plex Mono (labels/données).
- Détails complets dans `css/tokens.css`.

## Feuille de route (MVP)

Ordre de construction, calé sur le parcours utilisateur du document de
cadrage. Chaque page devient ensuite une vue ERB Rails.

| # | Page | Statut |
|---|------|--------|
| 1 | Page d'accueil + choix du type de compte | ✅ fait |
| 2 | Inscription / Connexion (Étudiant, Entreprise, Formateur) | ✅ fait |
| 3 | Dashboard (version simple par rôle) | ✅ fait |
| 4 | Gestion du profil (étudiant + entreprise) | ✅ fait |
| 5 | Recherche d'offres (étudiant) | ✅ fait |
| 6 | Publication d'offres (entreprise) | ✅ fait |
| 7 | Candidature à une offre | ✅ fait |
| 8 | Formations : création (formateur) + consultation (étudiant) | ✅ fait |


**Statut : ✅ toutes réalisées.** Le frontend statique couvre désormais
l'intégralité du parcours utilisateur décrit dans le document de cadrage,
pour les 3 rôles (Étudiant, Entreprise, Formateur).

## Prochaine étape

Backend Ruby on Rails : modèles, migrations, contrôleurs — à partir du
modèle de données du document de cadrage, confronté aux champs des
formulaires déjà construits.

## Migration vers Rails

- `css/*.css` → `app/assets/stylesheets/`
- `js/*.js` → `app/javascript/` (ou `app/assets/javascripts/`)
- Header/footer de `layout.css` → `app/views/layouts/application.html.erb`
- Chaque page de `pages/` → vue ERB correspondante + partial si répété
