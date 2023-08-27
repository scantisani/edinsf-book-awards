import * as React from 'react'
import { useSortable } from '@dnd-kit/sortable'
import { CSS } from '@dnd-kit/utilities'
import { Book } from '../interfaces/book'

type BookCardProps = Book & {position: number}

const BookCard = ({ id, title, author, position }: BookCardProps): JSX.Element => {
  const { attributes, listeners, setNodeRef, transform, transition } = useSortable({ id })

  const style = { transform: CSS.Transform.toString(transform), transition }

  return (
    <div ref={setNodeRef} style={style} {...attributes} {...listeners} className='card'>
      <div className='card-header has-background-primary'>
        <h2 className='card-header-title'>
          {`#${position + 1} ${title}`}
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
