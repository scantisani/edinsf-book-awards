import { render, screen, waitForElementToBeRemoved } from '@testing-library/react'
import App from './app'
import * as React from 'react'
import { setupServer } from 'msw/node'
import { rest } from 'msw'

describe('App', () => {
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

  it('renders "Loading" while requesting books, then renders cards with a title and author', async () => {
    render(<App/>)

    expect(screen.getByText(/loading/i)).toBeInTheDocument()

    await waitForElementToBeRemoved(() => screen.queryByText(/loading/i))
    for (const { title, author } of books) {
      expect(screen.getByText(title)).toBeInTheDocument()
      expect(screen.getByText(author)).toBeInTheDocument()
    }
  })
})
