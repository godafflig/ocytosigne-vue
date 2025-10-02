-- SQL pour créer la table praticiens dans Supabase
-- Exécutez ce script dans l'éditeur SQL de Supabase

CREATE TABLE praticiens (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  specialty VARCHAR(255) NOT NULL,
  video_url TEXT,
  rating DECIMAL(2,1) DEFAULT 0,
  reviews_count INTEGER DEFAULT 0,
  location VARCHAR(255) NOT NULL,
  availability VARCHAR(255),
  lsf_level VARCHAR(100),
  image_url TEXT,
  badges JSONB DEFAULT '[]',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insertion de données d'exemple
INSERT INTO praticiens (name, specialty, video_url, rating, reviews_count, location, availability, lsf_level, image_url, badges) VALUES
('Dr. Marie Dubois', 'Médecin généraliste', 'https://elix-lsf.s3.rbx.io.cloud.ovh.net/spip_videos/00009-3.mp4', 4.9, 127, 'Paris 11ème', 'Disponible aujourd''hui', 'LSF Natif', 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=300&h=300&fit=crop&crop=face', '["LSF", "Urgences"]'),
('Dr. Thomas Martin', 'Psychologue', 'https://elix-lsf.s3.rbx.io.cloud.ovh.net/spip_videos/psychologue_adjetn_1_2.mp4', 4.8, 89, 'Lyon 3ème', 'Demain 14h', 'LSF Certifié', 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=300&h=300&fit=crop&crop=face', '["LSF", "Thérapie"]'),
('Dr. Sophie Leroy', 'Dermatologue', 'https://elix-lsf.s3.rbx.io.cloud.ovh.net/spip_videos/dermatologue_nm_1_1.mp4', 4.9, 156, 'Marseille 1er', 'Lundi 9h', 'LSF Expert', null, '["LSF", "Téléconsultation"]'),
('Dr. Ahmed Benali', 'Cardiologue', 'https://elix-lsf.s3.rbx.io.cloud.ovh.net/spip_videos/cardiologue_nm_1_1.mp4', 4.7, 203, 'Toulouse Centre', 'Mercredi 15h', 'LSF Avancé', 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=300&h=300&fit=crop&crop=face', '["LSF", "Spécialiste"]'),
('Dr. Claire Moreau', 'Pédiatre', 'https://elix-lsf.s3.rbx.io.cloud.ovh.net/spip_videos/pediatre_nm_1_2.mp4', 4.9, 174, 'Nantes Sud', 'Aujourd''hui 16h', 'LSF Natif', 'https://images.unsplash.com/photo-1551601651-2a8555f1a136?w=300&h=300&fit=crop&crop=face', '["LSF", "Enfants"]'),
('Dr. Paul Rousseau', 'Kinésithérapeute', 'https://elix-lsf.s3.rbx.io.cloud.ovh.net/spip_videos/kinesitherapeute_nm_1_1.mp4', 4.6, 92, 'Bordeaux Centre', 'Vendredi 10h', 'LSF Certifié', 'https://images.unsplash.com/photo-1607990281513-2c110a25bd8c?w=300&h=300&fit=crop&crop=face', '["LSF", "Réhabilitation"]');

-- Politique de sécurité pour permettre la lecture publique
ALTER TABLE praticiens ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read access" ON praticiens
FOR SELECT USING (true);

-- Index pour optimiser les requêtes
CREATE INDEX idx_praticiens_specialty ON praticiens(specialty);
CREATE INDEX idx_praticiens_location ON praticiens(location);