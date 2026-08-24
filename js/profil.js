/* ==========================================================================
   SkillLink — profil.js
   Ajout/suppression de compétences (tags) + affichage du nom de fichier
   sélectionné dans les zones d'upload (CV, logo).
   ========================================================================== */

document.addEventListener("DOMContentLoaded", () => {
  initSkillsInput();
  initUploadZones();
});

/**
 * Champ "Compétences" : taper puis Entrée (ou bouton +) ajoute un tag.
 * Chaque tag a un bouton × pour le retirer.
 */
function initSkillsInput() {
  const input = document.querySelector("[data-skill-input]");
  const addBtn = document.querySelector("[data-skill-add]");
  const list = document.querySelector("[data-skills-list]");
  if (!input || !list) return;

  const addSkill = () => {
    const value = input.value.trim();
    if (!value) return;

    const tag = document.createElement("span");
    tag.className = "skill-tag";
    tag.innerHTML = `${escapeHtml(value)} <button type="button" aria-label="Retirer ${escapeHtml(value)}">×</button>`;
    tag.querySelector("button").addEventListener("click", () => tag.remove());

    list.appendChild(tag);
    input.value = "";
    input.focus();
  };

  input.addEventListener("keydown", (e) => {
    if (e.key === "Enter") {
      e.preventDefault();
      addSkill();
    }
  });

  addBtn?.addEventListener("click", addSkill);

  list.querySelectorAll(".skill-tag button").forEach((btn) => {
    btn.addEventListener("click", () => btn.closest(".skill-tag").remove());
  });
}

function escapeHtml(str) {
  const div = document.createElement("div");
  div.textContent = str;
  return div.innerHTML;
}

/**
 * Zones d'upload (CV, logo) : clic ou glisser-déposer, affiche le nom
 * du fichier sélectionné.
 */
function initUploadZones() {
  document.querySelectorAll("[data-upload-zone]").forEach((zone) => {
    const fileInput = zone.querySelector("input[type=file]");
    const filenameEl = zone.querySelector("[data-upload-filename]");
    if (!fileInput) return;

    zone.addEventListener("click", () => fileInput.click());

    fileInput.addEventListener("change", () => {
      if (fileInput.files.length && filenameEl) {
        filenameEl.textContent = "Fichier sélectionné : " + fileInput.files[0].name;
      }
    });

    ["dragover", "dragleave", "drop"].forEach((evt) => {
      zone.addEventListener(evt, (e) => {
        e.preventDefault();
        zone.classList.toggle("is-dragover", evt === "dragover");
      });
    });

    zone.addEventListener("drop", (e) => {
      if (e.dataTransfer.files.length) {
        fileInput.files = e.dataTransfer.files;
        if (filenameEl) filenameEl.textContent = "Fichier sélectionné : " + e.dataTransfer.files[0].name;
      }
    });
  });
}
