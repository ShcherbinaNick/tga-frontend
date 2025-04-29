import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    host: '0.0.0.0',      // Access from outside
    port: 5173,
    strictPort: true,
    cors: true,
    hmr: {
      clientPort: 443     // For HTTPS tunnels (Serveo, Ngrok, etc.)
    },
    allowedHosts: ['.serveo.net']  // Accept Serveo subdomains
  }
})
