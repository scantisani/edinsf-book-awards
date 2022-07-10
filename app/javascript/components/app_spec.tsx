import { render, screen } from '@testing-library/react'
import App from './app'
import * as React from 'react'

test('main page renders text', () => {
  const argument = 'foo'
  render(<App arg={argument} />)

  expect(screen.getByText(`Hello, ${argument}!`)).toBeInTheDocument()
})
