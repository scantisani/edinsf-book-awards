import * as React from 'react'
import { fireEvent, render, screen } from '@testing-library/react'
import SortableBookList from './sortable_book_list'

describe('SortableBookList', () => {
  const books = [
    { id: 1, title: 'Priestdaddy', author: 'Patricia Lockwood' },
    { id: 2, title: 'The Pastel City', author: 'M. John Harrison' },
    { id: 3, title: 'Dreamsnake', author: 'Vonda N. McIntyre' }
  ]

  it('renders nothing if `books` is empty', () => {
    render(<SortableBookList books={[]} onBooksChange={() => {}} />)

    expect(screen.queryByRole('button')).not.toBeInTheDocument()
  })

  it('renders as many book items as there are books', () => {
    render(<SortableBookList books={books} onBooksChange={() => {}} />)

    expect(screen.getAllByRole('button').length).toEqual(3)
    for (const { title, author } of books) {
      expect(screen.getByText(title)).toBeInTheDocument()
      expect(screen.getByText(author)).toBeInTheDocument()
    }
  })

  // see Cypress spec for a more comprehensive drag-and-drop test
  it('allows items to be dragged', async () => {
    render(<SortableBookList books={books} onBooksChange={() => {}} />)

    const firstCard = screen.getByRole('button', { name: new RegExp(books[0].title, 'i') })

    fireEvent.mouseDown(firstCard)
    expect(screen.getByRole('status')).toHaveTextContent(/picked up/i)

    fireEvent.mouseUp(firstCard)
    expect(screen.getByRole('status')).toHaveTextContent(/dropped/i)
  })
})
