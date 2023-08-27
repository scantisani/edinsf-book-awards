import { Tab, TAB_NAMES } from '../interfaces/tab'
import * as React from 'react'

interface NavTabProps {
  tab: Tab
  selected?: boolean
  onTabClick: (tab: Tab) => void
}

const NavTab = ({ tab, selected = false, onTabClick }: NavTabProps): JSX.Element => {
  const name = TAB_NAMES[tab]

  if (selected) {
    return (
      <div className={'navbar-item is-tab is-active'}>
        {name}
      </div>
    )
  } else {
    return (
      <a className={'navbar-item is-tab'} href="#" onClick={() => onTabClick(tab)}>
        {name}
      </a>
    )
  }
}

export default NavTab
