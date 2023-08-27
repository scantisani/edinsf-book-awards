import * as React from 'react'
import { fireEvent, render, screen } from '@testing-library/react'
import NavTab from './nav_tab'
import { Tab } from '../interfaces/tab'

describe('NavTab', () => {
  const onTabClick = jest.fn()
  let tab: Tab

  beforeEach(() => (tab = Tab.YOUR_RANKING))

  it('should be a link', () => {
    render(<NavTab tab={tab} onTabClick={onTabClick} />)

    expect(screen.getByRole('link')).toBeInTheDocument()
  })

  describe('when using the YOUR_RANKING tab', () => {
    beforeEach(() => (tab = Tab.YOUR_RANKING))

    it('renders "Your Ranking"', () => {
      render(<NavTab tab={tab} onTabClick={onTabClick} />)

      expect(screen.getByText(/your ranking/i)).toBeInTheDocument()
    })
  })

  describe('when using the RESULTS tab', () => {
    beforeEach(() => (tab = Tab.RESULTS))

    it('renders "Results"', () => {
      render(<NavTab tab={tab} onTabClick={onTabClick}/>)

      expect(screen.getByText(/results/i)).toBeInTheDocument()
    })
  })

  describe('when it is clicked', () => {
    it('calls `onTabClick`', async () => {
      render(<NavTab tab={tab} onTabClick={onTabClick} />)

      const navTab = screen.getByRole('link')
      fireEvent.click(navTab)

      expect(onTabClick).toHaveBeenCalledWith(tab)
    })
  })

  describe('when selected', () => {
    it('should not be a link', () => {
      render(<NavTab tab={tab} onTabClick={onTabClick} selected={true} />)

      expect(screen.queryByRole('link')).not.toBeInTheDocument()
    })

    it('should not call `onTabClick`', () => {
      render(<NavTab tab={Tab.YOUR_RANKING} onTabClick={onTabClick} selected={true} />)

      const resultsTab = screen.getByText(/your ranking/i)
      fireEvent.click(resultsTab)

      expect(onTabClick).not.toHaveBeenCalled()
    })
  })
})
