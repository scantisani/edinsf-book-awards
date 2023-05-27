import * as React from 'react'
import { IconAward } from '@tabler/icons'

const Title = (): JSX.Element => {
  return (
    <header className="level">
      <div className="level-item">
        <h1 className="title">
          <span className="icon-text">
            <span className="icon is-medium">
              <IconAward />
            </span>

            The Edinburgh SF Book Club Awards

            <span className="icon is-medium">
              <IconAward />
            </span>
          </span>
        </h1>
      </div>
    </header>
  )
}

export default Title
