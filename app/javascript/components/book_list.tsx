import { Book } from './book'
import BookCard from './book_card'
import * as React from 'react'

const BookList = ({ books }: { books: Book[] }): JSX.Element => {
  return (
    <>
      {books.map(book => <BookCard {...book} key={book.id}/>)}
    </>
  )
}

export default BookList
