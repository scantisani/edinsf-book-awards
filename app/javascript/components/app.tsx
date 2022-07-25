import * as React from 'react'
import { useEffect, useState } from 'react'
import { Book } from './book'
import SortableBookList from './sortable_book_list'
import { createRanking, getBooks } from '../lib/requests'
import SaveIndicator from './save_indicator'
import SaveStatus from '../interfaces/save_status'

const App = (): JSX.Element => {
  enum LoadStatus { LOADING, SUCCESS, ERROR }
  const [loadStatus, setLoadStatus] = useState(LoadStatus.LOADING)

  const [saveStatus, setSaveStatus] = useState(SaveStatus.INITIAL)

  const [books, setBooks] = useState<Book[]>([])

  useEffect(() => {
    getBooks()
      .then(response => {
        setBooks(response.data)
        setLoadStatus(LoadStatus.SUCCESS)
      })
      .catch(() => {
        setLoadStatus(LoadStatus.ERROR)
      })
  }, [])

  const updateRanking = (books: Book[]): void => {
    setBooks(books)
    setSaveStatus(SaveStatus.SAVING)

    createRanking(books.map(book => book.id))
      .then(() => setSaveStatus(SaveStatus.SAVED))
      .catch(() => setSaveStatus(SaveStatus.ERROR))
  }

  const content = (): JSX.Element => {
    switch (loadStatus) {
      case LoadStatus.LOADING: return <div>Loading...</div>
      case LoadStatus.SUCCESS: return <SortableBookList books={books} onBooksChange={updateRanking} />
      case LoadStatus.ERROR: return <div>Failed to load books.</div>
    }
  }

  return (
    <div className='container is-max-desktop my-3'>
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
      {content()}
    </div>
  )
}

export default App
