/* ==========================================================================
   SkillLink — dashboard.js
   Bascule entre les 3 vues de dashboard (démo, sans backend).
   En Rails, ce sera simplement le rôle de current_user qui déterminera
   quelle vue/partial est rendue — plus besoin de JS pour ça.
   ========================================================================== */

document.addEventListener("DOMContentLoaded", () => {
  const params = new URLSearchParams(window.location.search);
  const role = params.get("role") || "etudiant";
  applyDashRole(role);

  document.querySelectorAll("[data-dash-role-link]").forEach((link) => {
    link.addEventListener("click", (e) => {
      e.preventDefault();
      const newRole = link.dataset.dashRoleLink;
      const url = new URL(window.location.href);
      url.searchParams.set("role", newRole);
      window.history.replaceState({}, "", url);
      applyDashRole(newRole);
    });
  });
});

function applyDashRole(role) {
  document.querySelectorAll("[data-dash-view]").forEach((el) => {
    el.classList.toggle("is-active", el.dataset.dashView === role);
  });
  document.querySelectorAll("[data-dash-role-link]").forEach((link) => {
    link.classList.toggle("is-active", link.dataset.dashRoleLink === role);
  });

  const labels = { etudiant: "Étudiant", entreprise: "Entreprise", formateur: "Formateur" };
  const nameEl = document.querySelector("[data-dash-user-role]");
  if (nameEl) nameEl.textContent = labels[role] || role;
}
