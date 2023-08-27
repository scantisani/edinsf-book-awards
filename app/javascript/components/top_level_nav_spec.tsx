import { fireEvent, render, screen } from '@testing-library/react'
import * as React from 'react'
import TopLevelNav from './top_level_nav'
import SaveStatus from '../interfaces/save_status'
import { Tab } from '../interfaces/tab'

describe('TopLevelNav', () => {
  const saveStatus = SaveStatus.INITIAL
  let currentTab = Tab.YOUR_RANKING

  const onTabClick = jest.fn()

  it('renders the "Your Ranking" and "Results" tabs', async () => {
    render(<TopLevelNav saveStatus={saveStatus} currentTab={currentTab} onTabClick={onTabClick}/>)

    expect(screen.getByText(/your ranking/i)).toBeInTheDocument()
    expect(screen.getByText(/results/i)).toBeInTheDocument()
  })

  describe('when "Your Ranking" is the active tab', () => {
    beforeEach(() => {
      currentTab = Tab.YOUR_RANKING
    })

    it('makes "Your Ranking" unclickable and renders "Results" as a link', async () => {
      render(<TopLevelNav saveStatus={saveStatus} currentTab={currentTab} onTabClick={onTabClick}/>)

      expect(screen.queryByRole('link', { name: /your ranking/i })).not.toBeInTheDocument()
      expect(screen.queryByRole('link', { name: /your ranking/i })).not.toBeInTheDocument()
      expect(screen.getByRole('link', { name: /results/i })).toBeInTheDocument()
    })
  })

  describe('when "Results" is the active tab', () => {
    beforeEach(() => {
      currentTab = Tab.RESULTS
    })

    it('makes "Results" unclickable and renders "Your Ranking" as a link', async () => {
      render(<TopLevelNav saveStatus={saveStatus} currentTab={currentTab} onTabClick={onTabClick}/>)

      expect(screen.queryByRole('link', { name: /results/i })).not.toBeInTheDocument()
      expect(screen.getByRole('link', { name: /your ranking/i })).toBeInTheDocument()
    })
  })
})
