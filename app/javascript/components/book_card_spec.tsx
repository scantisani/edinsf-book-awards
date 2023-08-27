import * as React from 'react'
import { render, screen } from '@testing-library/react'
import BookCard from './book_card'

describe('BookCard', () => {
  const id = 1
  const title = 'Priestdaddy'
  const author = 'Patricia Lockwood'

  it('renders the book title and author', () => {
    render(<BookCard id={id} title={title} author={author} position={0}/>)

    expect(screen.getByText(title, { exact: false })).toBeInTheDocument()
    expect(screen.getByText(author)).toBeInTheDocument()
  })

  it('has a `button` role', () => {
    render(<BookCard id={id} title={title} author={author} position={0} />)

    expect(screen.getByRole('button')).toBeInTheDocument()
  })

  it('displays its index with one added', () => {
    render(<BookCard id={id} title={title} author={author} position={0}/>)
    expect(screen.getByText(/#1/)).toBeInTheDocument()

    render(<BookCard id={id} title={title} author={author} position={5}/>)
    expect(screen.getByText(/#6/)).toBeInTheDocument()
  })
})
