import React from 'react'
import { createRoot } from 'react-dom/client'
import App from './components/app'

document.addEventListener('DOMContentLoaded', () => {
  const container = document.getElementById('container')
  const root = createRoot(container!)
  root.render(<App arg={'Rails 7 with ESBuild'} />)
})
