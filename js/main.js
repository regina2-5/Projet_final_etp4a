/* ==========================================================================
   SkillLink — main.js
   Comportements partagés par toutes les pages (menu, utilitaires).
   Chaque page ajoutera son propre fichier JS pour ses besoins spécifiques
   (ex: pages/offres.js pour les filtres de recherche).
   ========================================================================== */

document.addEventListener("DOMContentLoaded", () => {
  initMobileNav();
});

/**
 * Menu mobile simple (à étoffer si besoin d'un vrai drawer).
 */
function initMobileNav() {
  const toggle = document.querySelector("[data-nav-toggle]");
  const nav = document.querySelector("[data-nav]");
  if (!toggle || !nav) return;

  toggle.addEventListener("click", () => {
    const isOpen = nav.classList.toggle("is-open");
    toggle.setAttribute("aria-expanded", String(isOpen));
  });
}
