// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2024-11-01',
  devtools: { enabled: true },
  vite: {
    server: {
      host: '0.0.0.0', // Allow external network access
      strictPort: true,
      allowedHosts: ['prfsdashboard2.bankmegadev.local'],
    }
  }
})
