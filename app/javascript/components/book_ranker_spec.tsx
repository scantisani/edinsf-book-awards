import { render, screen, waitForElementToBeRemoved } from '@testing-library/react'
import * as React from 'react'
import { setupServer } from 'msw/node'
import { rest } from 'msw'
import BookRanker from './book_ranker'

describe('BookRanker', () => {
  const books = [
    { id: 1, title: 'Priestdaddy', author: 'Patricia Lockwood' },
    { id: 2, title: 'The Pastel City', author: 'M. John Harrison' }
  ]

  const server = setupServer(
    rest.get('/books', (req, res, ctx) => {
      return res(ctx.json(books))
    })
  )

  beforeAll(() => server.listen())
  afterEach(() => server.resetHandlers())
  afterAll(() => server.close())

  it('renders a "Loading" placeholder, then cards with a title and author', async () => {
    render(<BookRanker onRankingSave={() => {}}/>)

    expect(screen.getByText(/loading/i)).toBeInTheDocument()

    await waitForElementToBeRemoved(() => screen.queryByText(/loading/i))
    for (const { title, author } of books) {
      expect(screen.getByText(title)).toBeInTheDocument()
      expect(screen.getByText(author)).toBeInTheDocument()
    }
  })

  it('renders "Failed to load books" when the request fails', async () => {
    server.use(
      rest.get('/books', (req, res, ctx) => {
        return res(ctx.status(500))
      })
    )

    render(<BookRanker onRankingSave={() => {}}/>)

    await waitForElementToBeRemoved(() => screen.queryByText(/loading/i))
    expect(screen.getByText(/failed to load books/i)).toBeInTheDocument()
  })
})
