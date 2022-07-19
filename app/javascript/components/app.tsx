import * as React from 'react'
import BookCard from './book_card'
import { useEffect, useState } from 'react'
import axios from 'axios'

const App = (): JSX.Element => {
  enum Status { LOADING, SUCCESS, ERROR }

  const [status, setStatus] = useState(Status.LOADING)
  const [books, setBooks] = useState([])

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
    return books.map(({ id, title, author }) => <BookCard id={id} title={title} author={author} key={id}/>)
  }

  const content = (): JSX.Element => {
    switch (status) {
      case Status.LOADING: return <div>Loading...</div>
      case Status.SUCCESS: return <>{bookCards()}</>
      case Status.ERROR: return <div>Failed to load books.</div>
    }
  }

  return (
    <div className='container is-max-desktop'>
      {content()}
    </div>
  )
}

export default App
