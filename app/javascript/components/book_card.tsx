import * as React from 'react'
import { Book } from './book'

const BookCard = ({ id, title, author }: Book): JSX.Element => {
  return (
    <div className='card'>
      <div className='card-header has-background-primary'>
        <h2 className='card-header-title'>
          {title}
        </h2>
      </div>
      <div className='card-content'>
        <p className='content'>
          <i>{author}</i>
        </p>
      </div>
    </div>
  )
}

export default BookCard
