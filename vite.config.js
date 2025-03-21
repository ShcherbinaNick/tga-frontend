import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    host: '0.0.0.0', // Доступ извне
    port: 5173,      // Ваш порт
    strictPort: true // Фиксируем порт
  }
})
