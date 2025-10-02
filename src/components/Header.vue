<script setup>
document.addEventListener("DOMContentLoaded", function () {
  const burger = document.getElementById("nav-burger");
  const menu = document.getElementById("nav-menu");
  const navLinks = document.querySelectorAll(".nav-link");

  if (burger) {
    burger.addEventListener("click", function (e) {
      e.stopPropagation();
      const expanded = burger.getAttribute("aria-expanded") === "true";
      burger.setAttribute("aria-expanded", !expanded);
      menu.classList.toggle("open");
      burger.classList.toggle("active"); // Ajoute/retire la classe active
    });

    document.addEventListener("click", function (e) {
      if (!menu.contains(e.target) && !burger.contains(e.target)) {
        menu.classList.remove("open");
        burger.setAttribute("aria-expanded", "false");
        burger.classList.remove("active"); // Retire la classe active
      }
    });

    document.addEventListener("keydown", function (e) {
      if (e.key === "Escape" && menu.classList.contains("open")) {
        menu.classList.remove("open");
        burger.setAttribute("aria-expanded", "false");
        burger.classList.remove("active"); // Retire la classe active
        burger.focus();
      }
    });

    navLinks.forEach((link) => {
      link.addEventListener("click", function () {
        menu.classList.remove("open");
        burger.setAttribute("aria-expanded", "false");
        burger.classList.remove("active"); // Retire la classe active
      });
    });
  }
});
</script>

<template>
  <header class="header" role="banner">
    <nav id="primary-navigation" class="nav" aria-label="Navigation principale">
      <div class="nav-container">
        <!-- Section gauche: Logo et titre -->
        <div class="nav-left" aria-label="Identité du site">
          <img
            src="../../src/assets/logo.png"
            alt="Logo Ocytosigne"
            class="nav-logo"
          />
          <div class="nav-titles" aria-hidden="false">
            <span class="nav-title-top">SantéAccess</span>
            <span class="nav-title-bottom">accessibilité à tous</span>
          </div>
        </div>

        <!-- Section centre: Navigation principale (desktop) -->
        <ul class="nav-links-desktop" aria-label="Liens principaux">
          <li><a href="#how" class="nav-link">Patients</a></li>
          <li><a href="#praticien" class="nav-link">Praticien</a></li>
          <li><a href="#accessibilite" class="nav-link">Accessibilité</a></li>
          <li><a href="#contact" class="nav-link">Contact</a></li>
        </ul>

        <!-- Section droite: Boutons d'action -->
        <div class="nav-actions">
          <button class="nav-urg" id="nav-urg" aria-label="Urgence 24h">
            <span class="urg-icon">
              <img
                src="../../src/assets/phone.png"
                alt=""
                aria-hidden="true"
                class="nav-logo"
              />
            </span>
            <span class="urg-text">Urgence 24h</span>
          </button>

          <button class="nav-login" id="nav-login" aria-label="Se connecter">
            <span class="login-icon">
              <img
                src="../../../src/assets/profile.png"
                alt=""
                aria-hidden="true"
                class="nav-logo"
              />
            </span>
            <span class="login-text">Connexion</span>
          </button>

          <!-- Burger menu (mobile seulement) -->
          <button
            class="nav-burger"
            id="nav-burger"
            aria-label="Ouvrir le menu"
            aria-expanded="false"
            aria-controls="nav-menu"
          >
            <span class="burger-bar" aria-hidden="true"></span>
            <span class="burger-bar" aria-hidden="true"></span>
            <span class="burger-bar" aria-hidden="true"></span>
          </button>
        </div>
      </div>

      <!-- Menu mobile (burger) -->
      <ul
        class="nav-menu"
        id="nav-menu"
        role="list"
        aria-label="Liens principaux"
      >
        <li style="padding: 1rem 0;" role="listitem"><a href="#how" class="nav-link">Patients</a></li>
        <li style="padding: 1rem 0;" role="listitem">
          <a href="#praticien" class="nav-link">Praticien</a>
        </li>
        <li style="padding: 1rem 0;" role="listitem">
          <a href="#accessibilite" class="nav-link">Accessibilité</a>
        </li>
        <li style="padding: 1rem 0;" role="listitem">
          <a href="#contact" class="nav-link">Contact</a>
        </li>
      </ul>
    </nav>
  </header>
</template>

<style scoped>
/* === HEADER & NAVIGATION === */
.header {
  width: 100%;
  background: #fff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
  position: relative;
  z-index: 1001;
  overflow-x: hidden;
}

li {
  list-style: none;
}

.nav {
  width: 100%;
}

/* === NAV CONTAINER === */
.nav-container {
  height: 10vh;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0.5rem;
  max-width: 100%;
  overflow: hidden;
}

/* === NAV ACTIONS === */
.nav-actions {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.nav-left {
  display: flex;
  align-items: center;
  gap: 0.7rem;
}

.nav-logo {
  height: 40px;
  width: 40px;
  border-radius: 30%;
}

.nav-titles {
  display: flex;
  flex-direction: column;
  justify-content: center;
  line-height: 1.1;
}

.nav-title-top {
  font-size: 1.1rem;
  font-weight: 600;
  color: #2c323e;
  letter-spacing: 0.5px;
}

.nav-title-bottom {
  font-size: 0.95rem;
  color: #8195be;
  font-weight: 400;
  letter-spacing: 0.2px;
}

/* === NAVIGATION LINKS DESKTOP === */
.nav-links-desktop {
  display: none; /* Masqué par défaut (mobile first) */
  list-style: none;
  margin: 0;
  padding: 0;
  gap: 2rem;
}

.nav-links-desktop li {
  display: inline;
}

.nav-links-desktop .nav-link {
  color: #8195be;
  text-decoration: none;
  font-size: 1rem;
  font-weight: 500;
  padding: 0.5rem 1rem;
  border-radius: 6px;
  transition: background-color 0.2s, color 0.2s;
}

.nav-links-desktop .nav-link:hover,
.nav-links-desktop .nav-link:focus {
  background-color: #f0f4ff;
  color: #f97823;
  outline: none;
}

/* === NAV ACTIONS === */
.nav-actions {
  display: flex;
  align-items: center;
  gap: 1rem;
}

/* === LOGIN BUTTON === */
.nav-login {
  background: #f97823;
  border: none;
  display: flex;
  align-items: center;
  font-size: 1rem;
  cursor: pointer;
  margin-left: 1rem;
  color: #fff;
  transition: background 0.2s, color 0.2s, transform 0.15s;
  padding: 0.5rem 1.2rem;
  border-radius: 6px;
  gap: 0.5rem;
  height: 50px;
}

.nav-login .login-icon {
  display: flex;
  align-items: center;
  font-size: 1.2em;
}

.nav-login:hover,
.nav-login:focus {
  color: #fff;
  transform: scale(1.07);
  outline: none;
}

.nav-login:hover .login-icon,
.nav-login:focus .login-icon {
  color: #fff;
}

/* === Urgence BUTTON === */
.nav-urg {
  display: none;
}

.nav-urg {
  background: #ffffff;
  border: none;
  display: flex;
  align-items: center;
  font-size: 1rem;
  cursor: pointer;
  margin-left: 1rem;
  color: #000000;
  transition: background 0.2s, color 0.2s, transform 0.15s;
  padding: 0.5rem 1.2rem;
  border-radius: 6px;
  gap: 0.5rem;
  border: solid 1px #c4c4c4;
  height: 50px;
}

.nav-urg .login-icon {
  display: flex;
  align-items: center;
  font-size: 1.2em;
}

.nav-urg:hover,
.nav-urg:focus {
  color: #fff;
  transform: scale(1.07);
  outline: none;
}

.nav-urg:hover .urg-icon,
.nav-urg:focus .urg-icon {
  color: #fff;
}

/* === BURGER BUTTON === */
.nav-burger {
  width: 38px;
  height: 38px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  padding: 5px;
  background: none;
  border: none;
  border-radius: 0;
  transition: background 0.2s;
  z-index: 1100;
  cursor: pointer;
}

.nav-burger:hover,
.nav-burger:focus {
  background: #e6f0fa;
  outline: none;
}

.burger-bar {
  width: 18px;
  height: 3px;
  background: #2c323e;
  border-radius: 2px;
  margin: 2px 0;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.nav-burger.active .burger-bar:nth-child(1) {
  transform: rotate(45deg) translate(4px, 4px);
}

.nav-burger.active .burger-bar:nth-child(2) {
  opacity: 0;
}

.nav-burger.active .burger-bar:nth-child(3) {
  transform: rotate(-45deg) translate(5px, -5px);
}

/* === MENU BURGER MOBILE === */
.nav-menu {
  display: flex;
  flex-direction: column;
  position: fixed;
  top: 10vh;
  left: 0;
  right: 0;
  width: 100%;
  background: #2c323e;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  z-index: 1000;
  border-radius: 0;
  overflow-y: auto;
  max-height: 0;
  opacity: 0;
  transition: max-height 0.4s cubic-bezier(0.4, 0, 0.2, 1), opacity 0.3s;
  pointer-events: none;
}

.nav-menu.open {
  max-height: 100vh;
  opacity: 1;
  pointer-events: auto;
  background-color: #f97823;
}

.nav-link {
  color: #fff;
  text-decoration: none;
  padding: 1.5rem 1rem;
  font-size: 1.2rem;
  text-align: left;
  text-decoration: none;
}

/* === RESPONSIVE === */
@media (max-width: 1120px) {
  .nav-title-top {
    font-size: 1rem;
  }

  .nav-left {
    gap: 0.5rem;
  }

  .nav-title-bottom {
    font-size: 0.85rem;
  }
}

@media (max-width: 768px) {
  .nav-container {
    padding: 0.25rem;
    gap: 0.25rem;
  }
  
  .nav-left {
    gap: 0.3rem;
  }
  
  .nav-titles {
    display: none;
  }
  
  .nav-login .login-text,
  .nav-urg .urg-text {
    display: none;
  }
  
  .nav-login,
  .nav-urg {
    padding: 0.5rem;
    margin-left: 0.25rem;
  }
  
  .nav-actions {
    gap: 0.5rem;
  }
}

/* === DESKTOP VERSION === */
@media (min-width: 1120px) {
  .nav-container {
    justify-content: space-between;
    padding: 0 2rem;
    gap: 2rem;
  }

  .nav-links-desktop {
    display: flex; /* Afficher les liens en desktop */
  }

  .nav-burger {
    display: none !important; /* Masquer le burger en desktop */
  }

  .nav-menu {
    display: none !important; /* Masquer le menu mobile en desktop */
  }

  .nav-actions {
    gap: 1.5rem;
  }
}

/* Masquer par défaut */
.nav-urg {
  display: none;
}

/* Afficher entre 750px et 1100px */
@media (min-width: 750px) {
  .nav-urg {
    display: flex;
    align-items: center;
    background: #fff;
    border: 1px solid #f97823;
    color: #f97823;
    font-weight: 600;
    padding: 0.5rem 1.2rem;
    border-radius: 6px;
    margin-left: 1rem;
    gap: 0.5rem;
    cursor: pointer;
    transition: background 0.2s, color 0.2s, transform 0.15s;
  }

  .nav-urg .urg-icon img {
    width: 22px;
    height: 22px;
  }

  .nav-urg:hover,
  .nav-urg:focus {
    background: #f97823;
    color: #fff;
    transform: scale(1.07);
  }
}
</style>
