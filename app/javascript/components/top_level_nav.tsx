import * as React from 'react'
import SaveIndicator from './save_indicator'
import SaveStatus from '../interfaces/save_status'

const TopLevelNav = ({ saveStatus }: { saveStatus: SaveStatus }): JSX.Element => {
  return (
    <nav className="level">
      <div className="level-left">
        <div className="level-item">
          <h1 className="title">Your Ranking</h1>
        </div>
      </div>
      <div className="level-right">
        <div className="level-item">
          <SaveIndicator saveStatus={saveStatus} />
        </div>
      </div>
    </nav>
  )
}

export default TopLevelNav
