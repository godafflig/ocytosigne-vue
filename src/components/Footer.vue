<template>
  <footer
    class="footer"
    role="contentinfo"
    aria-label="Pied de page"
    id="accessibilite"
  >
    <div class="footer-top" role="region" aria-label="Présentation">
      <div class="footer-brand">
        <img
          src="../../src/assets/logo.png"
          alt="Logo Ocytosigne"
          class="footer-logo"
        />
        <div class="footer-titles">
          <span class="footer-title-top">SantéAccess</span>
          <span class="footer-title-bottom">accessibilité à tous</span>
        </div>
      </div>
      <div class="footer-desc">
        Ocytosigne facilite la communication entre patients et professionnels de
        santé grâce à des solutions accessibles et inclusives pour tous.
      </div>
      <div class="footer-icons" aria-label="Engagements">
        <span
          class="footer-icon-block"
          role="img"
          aria-label="Service 100% LSF"
        >
          <img
            src="../../src/assets/logo.png"
            alt="Logo Ocytosigne"
            aria-hidden="true"
            class="footer-icon"
          />
          <span>100% LSF</span>
        </span>
        <span
          class="footer-icon-block"
          role="img"
          aria-label="Service 100% LSF"
        >
          <img
            src="../../src/assets/logo.png"
            alt="Logo Ocytosigne"
            aria-hidden="true"
            class="footer-icon"
          />
          <span>100% LSF</span>
        </span>
      </div>
    </div>

    <nav
      class="footer-nav-section"
      aria-label="Navigation de pied de page"
      id="contact"
    >
      <h3 class="footer-nav-title">Navigation</h3>
      <ul class="footer-nav-list" role="list">
        <li role="listitem">
          <a href="#home" class="footer-link">Revenir à l'accueil</a>
        </li>
        <li role="listitem">
          <a href="#how" class="footer-link">Comment ça marche</a>
        </li>
        <li role="listitem">
          <a href="#praticiens" class="footer-link">Praticiens</a>
        </li>
        <li role="listitem">
          <a href="#accessibilite" class="footer-link">Accessibilité</a>
        </li>
      </ul>
    </nav>

    <section
      class="footer-contact"
      role="region"
      aria-labelledby="footer-contact-title"
    >
      <h3 class="footer-contact-title" id="footer-contact-title">Contact</h3>
      <ul class="footer-contact-list" role="list">
        <li role="listitem">
          <span class="footer-contact-icon" aria-hidden="true">
            <img
              src="../../src/assets/phone-orange.png"
              alt="Icône téléphone"
              aria-hidden="true"
              class="nav-logo"
            />
          </span>
          <a href="tel:0123456789">01 23 45 67 89</a>
        </li>
        <li role="listitem">
          <span class="footer-contact-icon" aria-hidden="true">
            <img
              src="../../src/assets/mail.png"
              alt="Icône mail"
              aria-hidden="true"
              class="nav-logo"
            />
          </span>
          <a href="mailto:contact@ocytosigne.com">contact@ocytosigne.com</a>
        </li>
        <li role="listitem">
          <span class="footer-contact-icon" aria-hidden="true">
            <img
              src="../../src/assets/map.png"
              alt="Icône carte"
              aria-hidden="true"
              class="nav-logo"
            />
          </span>
          12 rue de la Santé, 75000 Paris
        </li>
      </ul>
    </section>

    <section
      class="footer-urgency"
      role="region"
      aria-labelledby="footer-urgency-title"
    >
      <h3 class="footer-urgency-title" id="footer-urgency-title">
        Urgence médicale
      </h3>
      <div class="footer-urgency-desc" id="footer-urgency-desc">
        Accès prioritaire disponible 24h/24h pour toute urgence médicale.
      </div>
      <button class="footer-urgency-btn" aria-describedby="footer-urgency-desc">
        Urgence
      </button>
    </section>

    <div class="footer-legal" aria-label="Mentions légales">
      <span>© 2025 Ocytosigne. Tous droits réservés.</span>
    </div>
  </footer>
</template>
<style scoped>
/* Ajoute à la fin de ton fichier */

.footer {
  background: #f7f8fa;
  color: #2c323e;
  padding: 2.5rem 1rem 1rem 1rem;
  font-family: "Inter", Arial, sans-serif;
}
.footer-top {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  gap: 1rem;
  border-bottom: 1px solid #e2e8f0;
  padding-bottom: 1.5rem;
}
.footer-brand {
  display: flex;
  align-items: center;
  gap: 1rem;
}
.footer-logo {
  width: 48px;
  height: 48px;
  border-radius: 30%;
}
.footer-titles {
  display: flex;
  flex-direction: column;
  line-height: 1.1;
}
.footer-title-top {
  font-size: 1.1rem;
  font-weight: 600;
  color: #2c323e;
}
.footer-title-bottom {
  font-size: 0.95rem;
  color: #8195be;
}
.footer-desc {
  margin-top: 0.5rem;
  font-size: 1rem;
  color: #4a5568;
  max-width: 500px;
}
.footer-icons {
  margin-top: 0.5rem;
  display: flex;
  gap: 1.5rem;
}
.footer-icon-block {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  background: #e6f0fa;
  border-radius: 8px;
  padding: 0.4rem 1rem;
  font-weight: 600;
  color: #2c323e;
}
.footer-icon {
  width: 28px;
  height: 28px;
}

.footer-nav-section {
  margin-top: 2rem;
}
.footer-nav-title {
  font-size: 1.1rem;
  font-weight: 600;
  margin-bottom: 0.7rem;
}
.footer-nav-list {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}
.footer-link {
  color: #2c323e;
  text-decoration: none;
  transition: color 0.2s;
}
.footer-link:hover {
  color: #f97823;
}

.footer-contact {
  margin-top: 2rem;
}
.footer-contact-title {
  font-size: 1.1rem;
  font-weight: 600;
  margin-bottom: 0.7rem;
}
.footer-contact-list {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.footer-contact-icon {
  margin-right: 0.5rem;
  font-size: 1.2em;
}
.nav-logo {
  width: 20px;
  height: 20px;
  border-radius: 30%;
  vertical-align: middle;
}
.footer-urgency {
  margin-top: 2.5rem;
  text-align: center;
  padding: 2rem 0 1rem 0;
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(44, 50, 62, 0.04);
}
.footer-urgency-title {
  font-size: 1.2rem;
  font-weight: 700;
  color: #f97823;
  margin-bottom: 0.5rem;
}
.footer-urgency-desc {
  color: #2c323e;
  margin-bottom: 1rem;
}
.footer-urgency-btn {
  background: #f97823;
  color: #fff;
  border: none;
  border-radius: 6px;
  padding: 0.7rem 2.2rem;
  font-size: 1.1rem;
  font-weight: 600;
  cursor: pointer;
  transition: background 0.2s, transform 0.15s;
}
.footer-urgency-btn:hover,
.footer-urgency-btn:focus {
  background: #d45e0c;
  transform: scale(1.05);
}

.footer-legal {
  text-align: center;
  color: #8195be;
  font-size: 0.95rem;
  margin-top: 2.5rem;
  padding-top: 1rem;
  border-top: 1px solid #e2e8f0;
}
.footer-logo {
  width: 24px;
  height: 24px;
  border-radius: 30%;
}

/* Responsive */
@media (min-width: 700px) {
  .footer-top {
    flex-direction: row;
    align-items: flex-start;
    gap: 2.5rem;
  }
  .footer-desc,
  .footer-icons {
    margin-top: 0;
  }
  .footer-nav-section,
  .footer-contact {
    display: inline-block;
    vertical-align: top;
    width: 45%;
  }
  .footer-contact {
    margin-left: 2rem;
  }
}
</style>