import { DndContext, DragEndEvent, MouseSensor, useSensor, useSensors } from '@dnd-kit/core'
import { arrayMove, SortableContext, verticalListSortingStrategy } from '@dnd-kit/sortable'
import * as React from 'react'
import { Book } from './book'
import { useState } from 'react'
import BookList from './book_list'

const SortableBookList = ({ initialBooks }: { initialBooks: Book[] }): JSX.Element => {
  const [books, setBooks] = useState(initialBooks)

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
    <DndContext onDragEnd={handleDragEnd} sensors={sensors}>
      <SortableContext items={books} strategy={verticalListSortingStrategy}>
        <BookList books={books}/>
      </SortableContext>
    </DndContext>
  )
}

export default SortableBookList
