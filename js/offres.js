/* ==========================================================================
   SkillLink — offres.js
   Filtrage côté client de la liste d'offres + aperçu live du formulaire
   de publication. En Rails, le filtrage réel se fera côté serveur
   (scopes ActiveRecord), ceci reste un prototype de l'expérience.
   ========================================================================== */

document.addEventListener("DOMContentLoaded", () => {
  initOfferFilters();
  initPublishPreview();
});

function initOfferFilters() {
  const searchInput = document.querySelector("[data-offer-search]");
  const domainSelect = document.querySelector("[data-offer-domain]");
  const typeSelect = document.querySelector("[data-offer-type]");
  const cards = document.querySelectorAll("[data-offer-card]");
  const countEl = document.querySelector("[data-offer-count]");
  if (!cards.length) return;

  const applyFilters = () => {
    const query = (searchInput?.value || "").toLowerCase().trim();
    const domain = domainSelect?.value || "";
    const type = typeSelect?.value || "";
    let visible = 0;

    cards.forEach((card) => {
      const text = card.dataset.offerSearch?.toLowerCase() || "";
      const matchesQuery = !query || text.includes(query);
      const matchesDomain = !domain || card.dataset.offerDomain === domain;
      const matchesType = !type || card.dataset.offerType === type;
      const show = matchesQuery && matchesDomain && matchesType;
      card.style.display = show ? "" : "none";
      if (show) visible++;
    });

    if (countEl) countEl.textContent = `${visible} offre${visible !== 1 ? "s" : ""} trouvée${visible !== 1 ? "s" : ""}`;
  };

  [searchInput, domainSelect, typeSelect].forEach((el) => {
    el?.addEventListener("input", applyFilters);
  });

  applyFilters();
}

/**
 * Aperçu live sur la page "Publier une offre" : reflète en temps réel
 * ce que verra un étudiant, pour donner un retour immédiat.
 */
function initPublishPreview() {
  const form = document.querySelector("[data-publish-form]");
  if (!form) return;

  const fields = {
    title: form.querySelector("#offer-title"),
    type: form.querySelector("#offer-type"),
    domain: form.querySelector("#offer-domain"),
    location: form.querySelector("#offer-location"),
    description: form.querySelector("#offer-description"),
  };

  const preview = {
    title: document.querySelector("[data-preview-title]"),
    type: document.querySelector("[data-preview-type]"),
    meta: document.querySelector("[data-preview-meta]"),
    description: document.querySelector("[data-preview-description]"),
  };

  const update = () => {
    if (preview.title) preview.title.textContent = fields.title?.value || "Titre de l'offre";
    if (preview.type) preview.type.textContent = fields.type?.value || "Type";
    if (preview.meta) {
      const parts = [fields.domain?.value, fields.location?.value].filter(Boolean);
      preview.meta.textContent = parts.join(" · ") || "Domaine · Localisation";
    }
    if (preview.description) {
      preview.description.textContent = fields.description?.value || "La description de l'offre apparaîtra ici au fur et à mesure de la saisie.";
    }
  };

  Object.values(fields).forEach((field) => field?.addEventListener("input", update));
  update();
}
