import * as React from 'react'
import { useEffect, useState } from 'react'
import { Book } from './book'
import SortableBookList from './sortable_book_list'
import { createRanking, getBooks } from '../lib/requests'

const App = (): JSX.Element => {
  enum Status { LOADING, SUCCESS, ERROR }

  const [status, setStatus] = useState(Status.LOADING)
  const [books, setBooks] = useState<Book[]>([])

  useEffect(() => {
    getBooks()
      .then(response => {
        setBooks(response.data)
        setStatus(Status.SUCCESS)
      })
      .catch(() => {
        setStatus(Status.ERROR)
      })
  }, [])

  const updateRanking = (books: Book[]): void => {
    setBooks(books)

    createRanking(books.map(book => book.id))
      .then(() => {})
      .catch(() => {})
  }

  const content = (): JSX.Element => {
    switch (status) {
      case Status.LOADING: return <div>Loading...</div>
      case Status.SUCCESS: return <SortableBookList books={books} onBooksChange={updateRanking} />
      case Status.ERROR: return <div>Failed to load books.</div>
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
      </nav>
      {content()}
    </div>
  )
}

export default App
