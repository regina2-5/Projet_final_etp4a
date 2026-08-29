/* ==========================================================================
   SkillLink — auth.js
   Bascule des champs selon le rôle choisi + validation légère des formulaires.
   ========================================================================== */

document.addEventListener("DOMContentLoaded", () => {
  initRoleSwitch();
  initFormValidation();
});

/**
 * Sur inscription.html : lit ?role=... dans l'URL pour présélectionner
 * l'onglet, et affiche/masque les blocs de champs spécifiques au rôle.
 */
function initRoleSwitch() {
  const tabs = document.querySelectorAll("[data-role-tab]");
  if (!tabs.length) return;

  const params = new URLSearchParams(window.location.search);
  const requestedRole = params.get("role");

  const applyRole = (role) => {
    document.querySelectorAll(".role-fields").forEach((el) => {
      el.classList.toggle("is-active", el.dataset.roleFields === role);
    });
  };

  tabs.forEach((tab) => {
    tab.addEventListener("change", () => {
      if (tab.checked) applyRole(tab.value);
    });
  });

  const preselected = [...tabs].find((t) => t.value === requestedRole);
  if (preselected) {
    preselected.checked = true;
    applyRole(preselected.value);
  } else {
    applyRole(tabs[0].value);
  }
}

/**
 * Validation simple côté client : affiche un message d'erreur sous chaque
 * champ requis vide ou invalide, sans bloquer silencieusement l'utilisateur.
 * (La validation définitive restera faite côté serveur par Rails.)
 */
function initFormValidation() {
  const forms = document.querySelectorAll("[data-validate]");

  forms.forEach((form) => {
    form.addEventListener("submit", (event) => {
      let hasError = false;

      form.querySelectorAll("[required]").forEach((field) => {
        const wrap = field.closest(".field");
        if (!wrap) return;
        let errorEl = wrap.querySelector(".field-error");

        const isEmpty = !field.value.trim();
        const isInvalidEmail = field.type === "email" && field.value && !field.value.includes("@");

        if (isEmpty || isInvalidEmail) {
          hasError = true;
          if (!errorEl) {
            errorEl = document.createElement("p");
            errorEl.className = "field-error";
            wrap.appendChild(errorEl);
          }
          errorEl.textContent = isEmpty
            ? "Ce champ est requis."
            : "Adresse email invalide.";
          field.setAttribute("aria-invalid", "true");
        } else if (errorEl) {
          errorEl.remove();
          field.removeAttribute("aria-invalid");
        }
      });

      if (hasError) event.preventDefault();
    });
  });
}
