import * as React from 'react'
import BookCard from './book_card'
import { useEffect, useState } from 'react'
import axios from 'axios'
import { DndContext, DragEndEvent, MouseSensor, useSensor, useSensors } from '@dnd-kit/core'
import { arrayMove, SortableContext, verticalListSortingStrategy } from '@dnd-kit/sortable'
import { Book } from './book'

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

  const bookCards = (): JSX.Element[] => {
    return books.map(book => <BookCard {...book} key={book.id}/>)
  }

  const content = (): JSX.Element => {
    switch (status) {
      case Status.LOADING: return <div>Loading...</div>
      case Status.SUCCESS: return <>{bookCards()}</>
      case Status.ERROR: return <div>Failed to load books.</div>
    }
  }

  const handleDragEnd = (event: DragEndEvent): void => {
    const { active, over } = event
    if (over == null) {
      return
    }

    if (active.id !== over.id) {
      setBooks(books => {
        const oldIndex = books.findIndex(book => book.id === active.id)
        const newIndex = books.findIndex(book => book.id === over.id)

        return arrayMove(books, oldIndex, newIndex)
      })
    }
  }

  const sensors = useSensors(
    useSensor(MouseSensor)
  )

  return (
    <div className='container is-max-desktop'>
      <DndContext onDragEnd={handleDragEnd} sensors={sensors}>
        <SortableContext items={books} strategy={verticalListSortingStrategy}>
          {content()}
        </SortableContext>
      </DndContext>
    </div>
  )
}

export default App
