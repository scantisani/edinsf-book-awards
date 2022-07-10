import { defineConfig } from 'cypress'

export default defineConfig({
  screenshotsFolder: 'tmp/cypress_screenshots',
  videosFolder: 'tmp/cypress_videos',
  trashAssetsBeforeRuns: false,

  e2e: {
    setupNodeEvents (on, config) {
      // implement node event listeners here
    }
  }
})
