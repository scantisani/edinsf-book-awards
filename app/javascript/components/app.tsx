import * as React from 'react'
import { useState } from 'react'
import SaveStatus from '../interfaces/save_status'
import TopLevelNav from './top_level_nav'
import BookRanker from './book_ranker'
import Title from './title'
import { Tab } from '../interfaces/tab'

const App = (): JSX.Element => {
  const [saveStatus, setSaveStatus] = useState(SaveStatus.INITIAL)
  const [currentTab, setCurrentTab] = useState(Tab.YOUR_RANKING)

  const mainContent = currentTab === Tab.YOUR_RANKING ? <BookRanker onRankingSave={setSaveStatus}/> : <>Winner: The Memory Police</>

  return (
    <div className='container is-max-desktop my-5'>
      <Title />
      <TopLevelNav saveStatus={saveStatus} currentTab={currentTab} onTabClick={setCurrentTab}/>

      <main>
        {mainContent}
      </main>
    </div>
  )
}

export default App
