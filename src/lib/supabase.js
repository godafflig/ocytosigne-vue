import { createClient } from '@supabase/supabase-js'

// Configuration Supabase - Remplacez par vos vraies valeurs
const supabaseUrl = 'YOUR_SUPABASE_URL'
const supabaseKey = 'YOUR_SUPABASE_ANON_KEY'

// Ces variables seront définies dans les variables d'environnement
// pour la production (GitHub Pages)
const supabase = createClient(
  import.meta.env.VITE_SUPABASE_URL || supabaseUrl,
  import.meta.env.VITE_SUPABASE_ANON_KEY || supabaseKey
)

export { supabase }