import { Book } from '../interfaces/book'
import BookCard from './book_card'
import * as React from 'react'

const BookList = ({ books }: { books: Book[] }): JSX.Element => {
  return (
    <>
      {books.map((book, index) => <BookCard {...book} position={index} key={book.id}/>)}
    </>
  )
}

export default BookList
