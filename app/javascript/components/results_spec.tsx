import { render, screen, waitForElementToBeRemoved } from '@testing-library/react'
import * as React from 'react'
import { setupServer } from 'msw/node'
import { rest } from 'msw'
import Results from './results'

describe('Results', () => {
  const books = [
    { id: 1, title: 'Ammonite', author: 'Nicola Griffith' },
    { id: 2, title: 'Lonely Castle in the Mirror', author: 'Mizuki Tsujimura' },
    { id: 3, title: 'Roadside Picnic', author: 'Arkady and Boris Strugatsky' }
  ]

  const server = setupServer(
    rest.get('/results', (req, res, ctx) => {
      return res(ctx.json(books))
    })
  )

  beforeAll(() => server.listen())
  afterEach(() => server.resetHandlers())
  afterAll(() => server.close())

  it('renders a "Loading" placeholder, then cards with a title and author in the order they were returned', async () => {
    render(<Results />)

    expect(screen.getByText(/loading/i)).toBeInTheDocument()

    await waitForElementToBeRemoved(() => screen.queryByText(/loading/i))

    expect(screen.getByText('#1 Ammonite')).toBeInTheDocument()
    expect(screen.getByText('Nicola Griffith')).toBeInTheDocument()

    expect(screen.getByText('#2 Lonely Castle in the Mirror')).toBeInTheDocument()
    expect(screen.getByText('Mizuki Tsujimura')).toBeInTheDocument()

    expect(screen.getByText('#3 Roadside Picnic')).toBeInTheDocument()
    expect(screen.getByText('Arkady and Boris Strugatsky')).toBeInTheDocument()
  })

  it('renders "Failed to load results" when the request fails', async () => {
    server.use(
      rest.get('/results', (req, res, ctx) => {
        return res(ctx.status(500))
      })
    )

    render(<Results />)

    await waitForElementToBeRemoved(() => screen.queryByText(/loading/i))
    expect(screen.getByText(/failed to load results/i)).toBeInTheDocument()
  })
})
