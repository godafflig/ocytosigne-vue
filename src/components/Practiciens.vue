
<template>
  <!-- Secti<template>
  <!-- Section praticiens -->
  <section
    id="praticien"
    class="praticiens-section"
    role="region"
    aria-labelledby="praticiens-title"
  >
    <div class="section-header">
      <h2 id="praticiens-title">Nos praticiens certifiés</h2>
      <p>
        Tous nos professionnels de santé sont formés et certifiés en Langue des
        Signes Française
      </p>
      <!-- Filtres -->
      <div class="filters">
        <button class="filter-btn active">Tous</button>
        <button class="filter-btn">Médecins généralistes</button>
        <button class="filter-btn">Spécialistes</button>
        <button class="filter-btn">Disponibles maintenant</button>
        <button class="filter-btn">Téléconsultation</button>
      </div>
    </div>

    <!-- Grille des praticiens -->
    <div class="praticiens-grid">
      <!-- État de chargement -->
      <div v-if="loading" class="loading-state">
        <p>🔄 Chargement des praticiens...</p>
      </div>

      <!-- État d'erreur -->
      <div v-else-if="error" class="error-state">
        <p>⚠️ Erreur de connexion à la base de données</p>
        <p class="error-message">{{ error }}</p>
        <p><small>Les données statiques sont affichées en secours.</small></p>
      </div>

      <!-- Liste des praticiens -->
      <div 
        v-for="(practitioner, index) in practitioners" 
        :key="practitioner.id || index" 
        class="praticien-card"
      >
        <div class="praticien-header">
          <div class="praticien-media">
            <video
              v-if="practitioner.video"
              :src="practitioner.video"
              muted
              autoplay
              loop
              playsinline
              preload="metadata"
              :poster="
                practitioner.image ||
                'https://via.placeholder.com/300x300?text=Profil'
              "
              :aria-label="`Présentation vidéo de ${practitioner.name}`"
            ></video>
            <img
              v-else
              :src="
                practitioner.image ||
                'https://via.placeholder.com/300x300?text=Profil'
              "
              :alt="practitioner.name"
            />
          </div>
          <div class="praticien-info">
            <p>{{ practitioner.specialty }}</p>
            <h3>{{ practitioner.name }}</h3>
            <p style="color: #e65100; font-weight: 600">
              {{ practitioner.lsfLevel }}
            </p>
          </div>
        </div>
        <div class="badges">
          <span v-for="badge in practitioner.badges" :key="badge" class="badge">
            {{ badge }}
          </span>
        </div>

        <div class="details">
          <p class="info rating">
            <i class="fa-solid fa-star"></i> {{ practitioner.rating }} ({{
              practitioner.reviews
            }}
            avis)
          </p>
          <p class="info">
            <i class="fa-solid fa-location-dot"></i> {{ practitioner.location }}
          </p>
          <p class="info availability">
            <i class="fa-solid fa-circle-check"></i>
            {{ practitioner.availability }}
          </p>
        </div>

        <button class="btn-primary rdv-btn" @click="openModal(practitioner)">
          Prendre rendez-vous
        </button>

        <div class="actions">
          <button><i class="fa-solid fa-video"></i> Vidéo LSF</button>
          <button>Profil complet</button>
        </div>
      </div>
    </div>

    <!-- Fenêtre modale de prise de rendez-vous -->
    <div
      v-if="showModal"
      class="modal"
      role="dialog"
      aria-modal="true"
      aria-labelledby="modal-praticien-name"
      aria-describedby="rdv-modal-desc"
      @click.self="closeModal"
    >
      <div class="modal-content">
        <button
          type="button"
          class="close"
          aria-label="Fermer la fenêtre"
          @click="closeModal"
        >
          &times;
        </button>

        <p id="rdv-modal-desc" class="sr-only">
          Fenêtre de prise de rendez-vous avec informations du praticien et
          sélection d'options.
        </p>

        <div class="modal-praticien" v-if="selectedPractitioner">
          <img
            :src="
              selectedPractitioner.image ||
              'https://via.placeholder.com/300x300?text=Profil'
            "
            :alt="`Portrait de ${selectedPractitioner.name}`"
            class="praticien-photo"
          />
          <div>
            <h3 id="modal-praticien-name">{{ selectedPractitioner.name }}</h3>
            <p>
              {{ selectedPractitioner.specialty }} –
              {{ selectedPractitioner.location }}
            </p>
            <span class="badge" aria-label="Communication en LSF">LSF</span>
            <span class="badge" aria-label="Sous-titres disponibles"
              >Sous-titres</span
            >
          </div>
        </div>

        <!-- Type de consultation -->
        <div class="modal-section">
          <h4>Type de consultation</h4>
          <button class="option-btn active">💻 Échange vidéo</button>
          <button class="option-btn">🏥 Présentiel</button>
        </div>

        <!-- Options d'accessibilité -->
        <div class="modal-section">
          <h4>Options d'accessibilité</h4>
          <label><input type="checkbox" /> Je souhaite un interprète LSF</label>
          <p class="note">
            ℹ️ Les sous-titres automatiques sont disponibles pour tous les
            échanges vidéo.
          </p>
        </div>
        <!-- Choix de date et créneaux -->
        <div class="modal-section">
          <h4>Choisir une date et un horaire</h4>
          <div class="dates">
            <button class="date-btn active">Lundi 15 janvier</button>
            <button class="date-btn">Mardi 16 janvier</button>
            <button class="date-btn">Mercredi 17 janvier</button>
          </div>
          <div class="slots">
            <button class="slot-btn">09:00</button>
            <button class="slot-btn">11:00</button>
            <button class="slot-btn">14:00</button>
            <button class="slot-btn">16:30</button>
          </div>
        </div>
        <!-- CTA -->
        <div class="modal-footer">
          <button class="cta-btn">Confirmer le rendez-vous</button>
        </div>
      </div>
    </div>

    <!-- Call to action -->
    <div class="cta">
      <p>Plus de 500 praticiens certifiés LSF dans toute la France</p>
      <button class="cta-btn">Voir tous les praticiens</button>
    </div>
  </section>
</template>
  <section
    id="praticien"
    class="praticiens-section"
    role="region"
    aria-labelledby="praticiens-title"
  >
    <div class="section-header">
      <h2 id="praticiens-title">Nos praticiens certifiés</h2>
      <p>
        Tous nos professionnels de santé sont formés et certifiés en Langue des
        Signes Française
      </p>
      <!-- Filtres -->
      <div class="filters">
        <button class="filter-btn active">Tous</button>
        <button class="filter-btn">Médecins généralistes</button>
        <button class="filter-btn">Spécialistes</button>
        <button class="filter-btn">Disponibles maintenant</button>
        <button class="filter-btn">Téléconsultation</button>
      </div>
    </div>
    <!-- Grille des praticiens (rendu Vue) -->
    <div class="praticiens-grid">
      <div
        v-for="(practitioner, index) in practitioners"
        :key="index"
        class="praticien-card"
      >
        <div class="praticien-header">
          <div class="praticien-media">
            <video
              v-if="practitioner.video"
              :src="practitioner.video"
              muted
              autoplay
              loop
              playsinline
              preload="metadata"
              :poster="
                practitioner.image ||
                'https://via.placeholder.com/300x300?text=Profil'
              "
              :aria-label="`Présentation vidéo de ${practitioner.name}`"
            ></video>
            <img
              v-else
              :src="
                practitioner.image ||
                'https://via.placeholder.com/300x300?text=Profil'
              "
              :alt="practitioner.name"
            />
          </div>
          <div class="praticien-info">
            <p>{{ practitioner.specialty }}</p>
            <h3>{{ practitioner.name }}</h3>
            <p style="color: #e65100; font-weight: 600">
              {{ practitioner.lsfLevel }}
            </p>
          </div>
        </div>
        <div class="badges">
          <span v-for="badge in practitioner.badges" :key="badge" class="badge">
            {{ badge }}
          </span>
        </div>

        <div class="details">
          <p class="info rating">
            <i class="fa-solid fa-star"></i> {{ practitioner.rating }} ({{
              practitioner.reviews
            }}
            avis)
          </p>
          <p class="info">
            <i class="fa-solid fa-location-dot"></i> {{ practitioner.location }}
          </p>
          <p class="info availability">
            <i class="fa-solid fa-circle-check"></i>
            {{ practitioner.availability }}
          </p>
        </div>

        <button class="btn-primary rdv-btn" @click="openModal(practitioner)">
          Prendre rendez-vous
        </button>

        <div class="actions">
          <button><i class="fa-solid fa-video"></i> Vidéo LSF</button>
          <button>Profil complet</button>
        </div>
      </div>
    </div>

    <!-- Fenêtre modale de prise de rendez-vous -->
    <div
      v-if="showModal"
      class="modal"
      role="dialog"
      aria-modal="true"
      aria-labelledby="modal-praticien-name"
      aria-describedby="rdv-modal-desc"
      @click.self="closeModal"
    >
      <div class="modal-content">
        <button
          type="button"
          class="close"
          aria-label="Fermer la fenêtre"
          @click="closeModal"
        >
          &times;
        </button>

        <p id="rdv-modal-desc" class="sr-only">
          Fenêtre de prise de rendez-vous avec informations du praticien et
          sélection d'options.
        </p>

        <div class="modal-praticien" v-if="selectedPractitioner">
          <img
            :src="
              selectedPractitioner.image ||
              'https://via.placeholder.com/300x300?text=Profil'
            "
            :alt="`Portrait de ${selectedPractitioner.name}`"
            class="praticien-photo"
          />
          <div>
            <h3 id="modal-praticien-name">{{ selectedPractitioner.name }}</h3>
            <p>
              {{ selectedPractitioner.specialty }} –
              {{ selectedPractitioner.location }}
            </p>
            <span class="badge" aria-label="Communication en LSF">LSF</span>
            <span class="badge" aria-label="Sous-titres disponibles"
              >Sous-titres</span
            >
          </div>
        </div>

        <!-- Type de consultation -->
        <div class="modal-section">
          <h4>Type de consultation</h4>
          <button class="option-btn active">💻 Échange vidéo</button>
          <button class="option-btn">🏥 Présentiel</button>
        </div>

        <!-- Options d’accessibilité -->
        <div class="modal-section">
          <h4>Options d'accessibilité</h4>
          <label><input type="checkbox" /> Je souhaite un interprète LSF</label>
          <p class="note">
            ℹ️ Les sous-titres automatiques sont disponibles pour tous les
            échanges vidéo.
          </p>
        </div>
        <!-- Choix de date et créneaux -->
        <div class="modal-section">
          <h4>Choisir une date et un horaire</h4>
          <div class="dates">
            <button class="date-btn active">Lundi 15 janvier</button>
            <button class="date-btn">Mardi 16 janvier</button>
            <button class="date-btn">Mercredi 17 janvier</button>
          </div>
          <div class="slots">
            <button class="slot-btn">09:00</button>
            <button class="slot-btn">11:00</button>
            <button class="slot-btn">14:00</button>
            <button class="slot-btn">16:30</button>
          </div>
        </div>
        <!-- CTA -->
        <div class="modal-footer">
          <button class="cta-btn">Confirmer le rendez-vous</button>
        </div>
      </div>
    </div>

    <!-- Call to action -->
    <div class="cta">
      <p>Plus de 500 praticiens certifiés LSF dans toute la France</p>
      <button class="cta-btn">Voir tous les praticiens</button>
    </div>
  </section>
</template>
<script setup>
import { ref, onMounted } from 'vue'
import { supabase } from '../lib/supabase.js'

// ==========================
// Données réactives
// ==========================
const showModal = ref(false)
const selectedPractitioner = ref(null)
const practitioners = ref([])
const loading = ref(true)
const error = ref(null)

// ==========================
// Fonctions Supabase
// ==========================
const fetchPractitioners = async () => {
  try {
    loading.value = true
    const { data, error: supabaseError } = await supabase
      .from('praticiens')
      .select('*')
      .order('name')

    if (supabaseError) {
      throw supabaseError
    }

    // Transformation des données pour correspondre au format attendu
    practitioners.value = data.map(practitioner => ({
      name: practitioner.name,
      specialty: practitioner.specialty,
      video: practitioner.video_url,
      rating: practitioner.rating,
      reviews: practitioner.reviews_count,
      location: practitioner.location,
      availability: practitioner.availability,
      lsfLevel: practitioner.lsf_level,
      image: practitioner.image_url,
      badges: practitioner.badges || []
    }))
  } catch (err) {
    console.error('Erreur lors du chargement des praticiens:', err)
    error.value = err.message
    
    // Données de fallback en cas d'erreur
    practitioners.value = [
      {
        name: "Dr. Marie Dubois",
        specialty: "Médecin généraliste",
        video: "https://elix-lsf.s3.rbx.io.cloud.ovh.net/spip_videos/00009-3.mp4",
        rating: 4.9,
        reviews: 127,
        location: "Paris 11ème",
        availability: "Disponible aujourd'hui",
        lsfLevel: "LSF Natif",
        image: "https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=300&h=300&fit=crop&crop=face",
        badges: ["LSF", "Urgences"],
      }
    ]
  } finally {
    loading.value = false
  }
}

// ==========================
// Méthodes Vue
// ==========================
const openModal = (practitioner) => {
  selectedPractitioner.value = practitioner
  showModal.value = true
}

const closeModal = () => {
  showModal.value = false
  selectedPractitioner.value = null
}

// ==========================
// Lifecycle
// ==========================
onMounted(() => {
  fetchPractitioners()
})
</script>

<style scoped>
/* Ajoutez ici vos styles CSS pour les praticiens */
</style>
