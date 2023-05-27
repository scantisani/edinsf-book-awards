import * as React from 'react'
import { useState } from 'react'
import SaveStatus from '../interfaces/save_status'
import TopLevelNav from './top_level_nav'
import BookRanker from './book_ranker'
import Title from './title'

const App = (): JSX.Element => {
  const [saveStatus, setSaveStatus] = useState(SaveStatus.INITIAL)

  return (
    <div className='container is-max-desktop my-5'>
      <Title />
      <TopLevelNav saveStatus={saveStatus}/>
      <BookRanker onRankingSave={setSaveStatus}/>
    </div>
  )
}

export default App
