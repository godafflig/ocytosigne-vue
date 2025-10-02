<template>
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
      <div class="filters">
        <button class="filter-btn active">Tous</button>
        <button class="filter-btn">Médecins généralistes</button>
        <button class="filter-btn">Spécialistes</button>
        <button class="filter-btn">Disponibles maintenant</button>
        <button class="filter-btn">Téléconsultation</button>
      </div>
    </div>

    <div class="praticiens-grid">
      <div v-if="loading" class="loading-state">
        <p>🔄 Chargement des praticiens...</p>
      </div>

      <div v-else-if="error" class="error-state">
        <p>⚠️ Erreur de connexion à la base de données</p>
        <p class="error-message">{{ error }}</p>
        <p><small>Les données statiques sont affichées en secours.</small></p>
      </div>

      <div 
        v-for="practitioner in practitioners" 
        :key="practitioner.id" 
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
              :poster="practitioner.image || 'https://via.placeholder.com/300x300?text=Profil'"
              :aria-label="`Présentation vidéo de ${practitioner.name}`"
            ></video>
            <img
              v-else
              :src="practitioner.image || 'https://via.placeholder.com/300x300?text=Profil'"
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
            <i class="fa-solid fa-star"></i> {{ practitioner.rating }} ({{ practitioner.reviews }} avis)
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
            :src="selectedPractitioner.image || 'https://via.placeholder.com/300x300?text=Profil'"
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
            <span class="badge" aria-label="Sous-titres disponibles">Sous-titres</span>
          </div>
        </div>

        <div class="modal-section">
          <h4>Type de consultation</h4>
          <button class="option-btn active">💻 Échange vidéo</button>
          <button class="option-btn">🏥 Présentiel</button>
        </div>

        <div class="modal-section">
          <h4>Options d'accessibilité</h4>
          <label><input type="checkbox" /> Je souhaite un interprète LSF</label>
          <p class="note">
            ℹ️ Les sous-titres automatiques sont disponibles pour tous les
            échanges vidéo.
          </p>
        </div>

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

        <div class="modal-footer">
          <button class="cta-btn">Confirmer le rendez-vous</button>
        </div>
      </div>
    </div>

    <div class="cta">
      <p>Plus de 500 praticiens certifiés LSF dans toute la France</p>
      <button class="cta-btn">Voir tous les praticiens</button>
    </div>
  </section>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { supabase } from '../lib/supabase.js'

const showModal = ref(false)
const selectedPractitioner = ref(null)
const practitioners = ref([])
const loading = ref(true)
const error = ref(null)

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

    practitioners.value = data.map(practitioner => ({
      id: practitioner.id,
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
    
    practitioners.value = [
      {
        id: 1,
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

const openModal = (practitioner) => {
  selectedPractitioner.value = practitioner
  showModal.value = true
}

const closeModal = () => {
  showModal.value = false
  selectedPractitioner.value = null
}

onMounted(() => {
  fetchPractitioners()
})
</script>

<style scoped>
.praticiens-section {
  padding: 60px 20px;
  background: #f8f9fa;
}

.section-header {
  text-align: center;
  margin-bottom: 40px;
}

.section-header h2 {
  font-size: 2.5rem;
  color: #2c3e50;
  margin-bottom: 15px;
}

.section-header p {
  font-size: 1.1rem;
  color: #666;
  max-width: 600px;
  margin: 0 auto;
}

.filters {
  display: flex;
  justify-content: center;
  gap: 10px;
  margin-top: 30px;
  flex-wrap: wrap;
}

.filter-btn {
  padding: 10px 20px;
  border: 2px solid #e74c3c;
  background: white;
  color: #e74c3c;
  border-radius: 25px;
  cursor: pointer;
  transition: all 0.3s ease;
  font-weight: 500;
}

.filter-btn.active,
.filter-btn:hover {
  background: #e74c3c;
  color: white;
}

.praticiens-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 30px;
  max-width: 1400px;
  margin: 0 auto;
}

.loading-state,
.error-state {
  grid-column: 1 / -1;
  text-align: center;
  padding: 40px;
  background: white;
  border-radius: 15px;
  box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

.error-message {
  color: #e74c3c;
  font-weight: bold;
  margin: 10px 0;
}

.praticien-card {
  background: white;
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 4px 15px rgba(0,0,0,0.1);
  transition: transform 0.3s ease;
}

.praticien-card:hover {
  transform: translateY(-5px);
}

.praticien-header {
  display: flex;
  align-items: center;
  padding: 20px;
}

.praticien-media {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  overflow: hidden;
  margin-right: 15px;
  flex-shrink: 0;
}

.praticien-media video,
.praticien-media img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.praticien-info h3 {
  margin: 5px 0;
  color: #2c3e50;
  font-size: 1.3rem;
}

.praticien-info p {
  margin: 2px 0;
  color: #666;
}

.badges {
  padding: 0 20px;
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
  margin-bottom: 15px;
}

.badge {
  background: #e74c3c;
  color: white;
  padding: 5px 12px;
  border-radius: 20px;
  font-size: 0.8rem;
  font-weight: bold;
}

.details {
  padding: 0 20px 15px;
}

.info {
  margin: 8px 0;
  color: #666;
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 0.95rem;
}

.info i {
  color: #e74c3c;
  width: 16px;
}

.rating {
  color: #f39c12;
  font-weight: bold;
}

.availability {
  color: #27ae60;
  font-weight: bold;
}

.btn-primary {
  width: calc(100% - 40px);
  margin: 15px 20px;
  padding: 12px;
  background: #e74c3c;
  color: white;
  border: none;
  border-radius: 8px;
  font-weight: bold;
  font-size: 1rem;
  cursor: pointer;
  transition: background 0.3s ease;
}

.btn-primary:hover {
  background: #c0392b;
}

.actions {
  display: flex;
  padding: 0 20px 20px;
  gap: 10px;
}

.actions button {
  flex: 1;
  padding: 8px;
  border: 1px solid #ddd;
  background: white;
  border-radius: 5px;
  cursor: pointer;
  transition: all 0.3s ease;
  font-size: 0.9rem;
}

.actions button:hover {
  background: #f8f9fa;
  border-color: #e74c3c;
}

.modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0,0,0,0.8);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.modal-content {
  background: white;
  border-radius: 15px;
  padding: 30px;
  max-width: 500px;
  width: 90%;
  max-height: 90vh;
  overflow-y: auto;
  position: relative;
}

.close {
  position: absolute;
  top: 15px;
  right: 20px;
  background: none;
  border: none;
  font-size: 24px;
  cursor: pointer;
  color: #999;
  transition: color 0.3s ease;
}

.close:hover {
  color: #e74c3c;
}

.modal-praticien {
  display: flex;
  align-items: center;
  margin-bottom: 30px;
  padding-bottom: 20px;
  border-bottom: 1px solid #eee;
}

.praticien-photo {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  margin-right: 15px;
  object-fit: cover;
}

.modal-section {
  margin-bottom: 25px;
}

.modal-section h4 {
  margin-bottom: 15px;
  color: #2c3e50;
  font-size: 1.1rem;
}

.option-btn {
  display: block;
  width: 100%;
  padding: 12px;
  margin-bottom: 10px;
  border: 2px solid #e74c3c;
  background: white;
  color: #e74c3c;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
  font-size: 1rem;
}

.option-btn.active,
.option-btn:hover {
  background: #e74c3c;
  color: white;
}

.dates,
.slots {
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
  margin-top: 10px;
}

.date-btn,
.slot-btn {
  padding: 8px 15px;
  border: 1px solid #ddd;
  background: white;
  border-radius: 5px;
  cursor: pointer;
  transition: all 0.3s ease;
  font-size: 0.9rem;
}

.date-btn.active,
.date-btn:hover,
.slot-btn:hover {
  background: #e74c3c;
  color: white;
  border-color: #e74c3c;
}

.note {
  font-size: 0.9rem;
  color: #666;
  margin-top: 10px;
  padding: 10px;
  background: #f8f9fa;
  border-radius: 5px;
}

.modal-footer {
  margin-top: 30px;
  padding-top: 20px;
  border-top: 1px solid #eee;
}

.cta {
  text-align: center;
  margin-top: 50px;
  padding: 40px 20px;
  background: white;
  border-radius: 15px;
  box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

.cta p {
  font-size: 1.2rem;
  margin-bottom: 20px;
  color: #2c3e50;
}

.cta-btn {
  background: #e74c3c;
  color: white;
  padding: 15px 30px;
  border: none;
  border-radius: 8px;
  font-size: 1.1rem;
  font-weight: bold;
  cursor: pointer;
  transition: background 0.3s ease;
}

.cta-btn:hover {
  background: #c0392b;
}

.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border: 0;
}

@media (max-width: 768px) {
  .praticiens-grid {
    grid-template-columns: 1fr;
    gap: 20px;
  }
  
  .section-header h2 {
    font-size: 2rem;
  }
  
  .filter-btn {
    padding: 8px 15px;
    font-size: 0.9rem;
  }
  
  .modal-content {
    width: 95%;
    padding: 20px;
  }
  
  .praticien-header {
    flex-direction: column;
    text-align: center;
  }
  
  .praticien-media {
    margin-right: 0;
    margin-bottom: 15px;
  }
}

@media (max-width: 480px) {
  .filters {
    gap: 5px;
  }
  
  .filter-btn {
    padding: 6px 12px;
    font-size: 0.8rem;
  }
  
  .dates,
  .slots {
    justify-content: center;
  }
}
</style>
