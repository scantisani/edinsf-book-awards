import * as React from 'react'
import { useEffect, useState } from 'react'
import { Book } from '../interfaces/book'
import SortableBookList from './sortable_book_list'
import { createRanking, getBooks } from '../lib/requests'
import SaveStatus from '../interfaces/save_status'
import LoadStatus from '../interfaces/load_status'
import TopLevelNav from './top_level_nav'

const App = (): JSX.Element => {
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

  const BookRanker = (): JSX.Element => {
    switch (loadStatus) {
      case LoadStatus.LOADING: return <div>Loading...</div>
      case LoadStatus.SUCCESS: return <SortableBookList books={books} onBooksChange={updateRanking} />
      case LoadStatus.ERROR: return <div>Failed to load books.</div>
    }
  }

  return (
    <div className='container is-max-desktop my-3'>
      <TopLevelNav saveStatus={saveStatus}/>
      <BookRanker />
    </div>
  )
}

export default App
