import * as React from 'react'
import { render, screen } from '@testing-library/react'
import SaveIndicator from './save_indicator'
import SaveStatus from '../interfaces/save_status'

describe('SaveIndicator', () => {
  it('renders nothing initially', () => {
    const { baseElement } = render(<SaveIndicator saveStatus={SaveStatus.INITIAL} />)

    expect(baseElement).toHaveTextContent('')
  })

  it('renders "saving" and a spinner while saving', () => {
    render(<SaveIndicator saveStatus={SaveStatus.SAVING} />)

    expect(screen.getByText(/saving.../i)).toBeInTheDocument()
  })

  it('renders "saved" on successful save', () => {
    render(<SaveIndicator saveStatus={SaveStatus.SAVED} />)

    expect(screen.getByText(/saved/i)).toBeInTheDocument()
  })

  it('renders an error message when saving fails', () => {
    render(<SaveIndicator saveStatus={SaveStatus.ERROR} />)

    expect(screen.getByText(/couldn't connect to the server/i)).toBeInTheDocument()
  })
})
