import * as React from 'react'
import { createRoot } from 'react-dom/client'

interface AppProps {
  arg: string;
}

const App = ({ arg }: AppProps) => {
  return <div className={'notification is-primary'}>{`Hello, ${arg}!`}</div>
}

document.addEventListener('DOMContentLoaded', () => {
  const container = document.getElementById('container')
  const root = createRoot(container!)
  root.render(<App arg="Rails 7 with ESBuild"/>)
})
