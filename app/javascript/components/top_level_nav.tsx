import * as React from 'react'
import SaveIndicator from './save_indicator'
import SaveStatus from '../interfaces/save_status'

const TopLevelNav = ({ saveStatus }: { saveStatus: SaveStatus }): JSX.Element => {
  return (
    <nav className="navbar">
      <div className="navbar-start">
        <div className="navbar-item">
          <b>Your Ranking</b>
        </div>
        <a className="navbar-item" href="#">
          Results
        </a>
      </div>

      <div className="navbar-end">
        <div className="level-item">
          <SaveIndicator saveStatus={saveStatus} />
        </div>
      </div>
    </nav>
  )
}

export default TopLevelNav
