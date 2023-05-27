import { render, screen } from '@testing-library/react'
import * as React from 'react'
import TopLevelNav from './top_level_nav'
import SaveStatus from '../interfaces/save_status'

describe('TopLevelNav', () => {
  const saveStatus = SaveStatus.INITIAL

  it('renders the "Your Ranking" and "Results" tabs', async () => {
    render(<TopLevelNav saveStatus={saveStatus}/>)

    expect(screen.getByText(/your ranking/i)).toBeInTheDocument()
    expect(screen.getByText(/results/i)).toBeInTheDocument()
  })
})
