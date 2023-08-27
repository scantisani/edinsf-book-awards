import * as React from 'react'
import { render, screen } from '@testing-library/react'
import BookList from './book_list'

describe('BookList', () => {
  it('renders nothing if `books` is empty', () => {
    render(<BookList books={[]}/>)

    expect(screen.queryByRole('button')).not.toBeInTheDocument()
  })

  it('renders as many book items, in order, as there are books', () => {
    const books = [
      { id: 1, title: 'Priestdaddy', author: 'Patricia Lockwood' },
      { id: 2, title: 'The Pastel City', author: 'M. John Harrison' }
    ]

    render(<BookList books={books}/>)

    expect(screen.getAllByRole('button')).toHaveLength(2)

    expect(screen.getByText('#1 Priestdaddy')).toBeInTheDocument()
    expect(screen.getByText('Patricia Lockwood')).toBeInTheDocument()

    expect(screen.getByText('#2 The Pastel City')).toBeInTheDocument()
    expect(screen.getByText('M. John Harrison')).toBeInTheDocument()
  })
})
