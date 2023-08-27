import * as React from 'react'
import SaveIndicator from './save_indicator'
import SaveStatus from '../interfaces/save_status'
import { Tab } from '../interfaces/tab'
import NavTab from './nav_tab'

const TabList = ({ currentTab, onTabClick }: { currentTab: Tab, onTabClick: (tab: Tab) => void }): JSX.Element => {
  return (
    <>
      {
        (Object.keys(Tab) as Tab[])
          .map(tab => {
            return <NavTab key={tab} tab={tab} selected={tab === currentTab} onTabClick={onTabClick} />
          })
      }
    </>
  )
}

interface TopLevelNavProps {
  saveStatus: SaveStatus
  currentTab: Tab
  onTabClick: (tab: Tab) => void
}

const TopLevelNav = ({ saveStatus, currentTab, onTabClick }: TopLevelNavProps): JSX.Element => {
  return (
    <nav className="navbar mb-4">
      <div className="navbar-start">
        <TabList currentTab={currentTab} onTabClick={onTabClick} />
      </div>

      <div className="navbar-end">
        <div className="level-item">
          <SaveIndicator saveStatus={saveStatus}/>
        </div>
      </div>
    </nav>
  )
}

export default TopLevelNav
