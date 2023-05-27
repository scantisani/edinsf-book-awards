import { render, screen } from '@testing-library/react'
import * as React from 'react'
import TopLevelNav from './top_level_nav'
import SaveStatus from '../interfaces/save_status'

describe('TopLevelNav', () => {
  it('renders the title', async () => {
    render(<TopLevelNav saveStatus={SaveStatus.INITIAL}/>)

    expect(screen.getByText(/your ranking/i)).toBeInTheDocument()
  })
})
