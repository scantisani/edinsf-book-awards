import { render, screen } from '@testing-library/react'
import * as React from 'react'
import Title from './title'

describe('Title', () => {
  it('renders the title text', async () => {
    render(<Title />)

    expect(screen.getByText(/the edinburgh sf book club awards/i)).toBeInTheDocument()
  })
})
