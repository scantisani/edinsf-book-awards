import * as React from 'react'
import { useEffect, useState } from 'react'
import { Book } from './book'
import SortableBookList from './sortable_book_list'
import { createRanking, getBooks } from '../lib/requests'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faRocket, faPlugCircleExclamation } from '@fortawesome/free-solid-svg-icons'

const App = (): JSX.Element => {
  enum LoadStatus { LOADING, SUCCESS, ERROR }
  const [loadStatus, setLoadStatus] = useState(LoadStatus.LOADING)

  enum SaveStatus { INITIAL, SAVING, SAVED, ERROR }
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

  const SaveIndicator = (): JSX.Element => {
    switch (saveStatus) {
      case SaveStatus.INITIAL:
        return <></>
      case SaveStatus.SAVING:
        return (
          <span className="icon-text">
            <span>Saving...</span>
            <span className="icon">
              <span className="spinning-circle ml-2"></span>
            </span>
          </span>
        )
      case SaveStatus.SAVED:
        return (
          <span className="icon-text">
            <span className="has-text-centered">Saved</span>
            <span className="icon has-text-success">
              <FontAwesomeIcon icon={faRocket} size={'lg'} />
            </span>
          </span>
        )
      case SaveStatus.ERROR:
        return (
          <span className="icon-text">
            <span>Couldn&apos;t connect to the server</span>
            <span className="icon has-text-danger">
              <FontAwesomeIcon icon={faPlugCircleExclamation} size={'lg'} />
            </span>
          </span>
        )
    }
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
            <SaveIndicator />
          </div>
        </div>
      </nav>
      {content()}
    </div>
  )
}

export default App
