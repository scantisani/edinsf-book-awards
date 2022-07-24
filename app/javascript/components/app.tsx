import * as React from 'react'
import { useEffect, useMemo, useState } from 'react'
import axios from 'axios'
import { Book } from './book'
import SortableBookList from './sortable_book_list'

const App = (): JSX.Element => {
  enum Status { LOADING, SUCCESS, ERROR }

  const [status, setStatus] = useState(Status.LOADING)
  const [books, setBooks] = useState<Book[]>([])

  useEffect(() => {
    axios.get('/books')
      .then(response => {
        setBooks(response.data)
        setStatus(Status.SUCCESS)
      })
      .catch(() => {
        setStatus(Status.ERROR)
      })
  }, [])

  const csrfToken = useMemo((): string => {
    return document.querySelector('meta[name=\'csrf-token\']')?.getAttribute('content') ?? ''
  }, [])

  const updateRanking = (books: Book[]): void => {
    setBooks(books)

    axios.post('/rankings',
      { order: books.map(book => book.id) },
      { headers: { 'X-CSRF-TOKEN': csrfToken } })
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
    <div className='container is-max-desktop'>
      {content()}
    </div>
  )
}

export default App
