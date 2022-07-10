import * as React from 'react'
import { render, screen } from '@testing-library/react'
import BookCard from './book_card'

describe('BookCard', () => {
  const title = 'Priestdaddy'
  const author = 'Patricia Lockwood'

  it('renders the book title and author', () => {
    render(<BookCard title={title} author={author}/>)

    expect(screen.getByText(title)).toBeInTheDocument()
    expect(screen.getByText(author)).toBeInTheDocument()
  })
})
