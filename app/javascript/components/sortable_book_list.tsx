import { DndContext, DragEndEvent, MouseSensor, useSensor, useSensors } from '@dnd-kit/core'
import { arrayMove, SortableContext, verticalListSortingStrategy } from '@dnd-kit/sortable'
import * as React from 'react'
import { Book } from '../interfaces/book'
import BookList from './book_list'

interface SortableBookListProps {
  books: Book[]
  onBooksChange: (books: Book[]) => void
}

const SortableBookList = ({ books, onBooksChange }: SortableBookListProps): JSX.Element => {
  const handleDragEnd = (event: DragEndEvent): void => {
    const { active, over } = event
    if (over == null) {
      return
    }

    if (active.id !== over.id) {
      const oldIndex = books.findIndex(book => book.id === active.id)
      const newIndex = books.findIndex(book => book.id === over.id)

      onBooksChange(arrayMove(books, oldIndex, newIndex))
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
