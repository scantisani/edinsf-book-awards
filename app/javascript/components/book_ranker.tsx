import * as React from 'react'
import { useEffect, useState } from 'react'
import { Book } from '../interfaces/book'
import SortableBookList from './sortable_book_list'
import { createRanking, getBooks } from '../lib/requests'
import SaveStatus from '../interfaces/save_status'
import LoadStatus from '../interfaces/load_status'

const BookRanker = ({ onRankingSave }: { onRankingSave: (saveStatus: SaveStatus) => void }): JSX.Element => {
  const [loadStatus, setLoadStatus] = useState(LoadStatus.LOADING)

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
    onRankingSave(SaveStatus.SAVING)

    createRanking(books.map(book => book.id))
      .then(() => onRankingSave(SaveStatus.SAVED))
      .catch(() => onRankingSave(SaveStatus.ERROR))
  }

  switch (loadStatus) {
    case LoadStatus.LOADING: return <div>Loading...</div>
    case LoadStatus.SUCCESS: return <SortableBookList books={books} onBooksChange={updateRanking} />
    case LoadStatus.ERROR: return <div>Failed to load books.</div>
  }
}

export default BookRanker
