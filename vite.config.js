import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vite.dev/config/
export default defineConfig({
  plugins: [vue()],
  base: '/ocytosigne-website-vue/', // Remplacez par le nom de votre repo GitHub
  build: {
    outDir: 'dist',
    assetsDir: 'assets'
  }
})
