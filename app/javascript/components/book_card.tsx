import * as React from 'react'

const BookCard = ({ id, title, author }: { id: number, title: string, author: string }): JSX.Element => {
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
