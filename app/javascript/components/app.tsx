import * as React from 'react'
import BookCard from './book_card'
import { useEffect, useState } from 'react'
import axios from 'axios'

const App = () => {
  const [loading, setLoading] = useState(true)
  const [books, setBooks] = useState([])

  useEffect(() => {
    axios.get('/books')
      .then(response => {
        setBooks(response.data)
        setLoading(false)
      })
  }, [])

  const bookCards = () => {
    return books.map(({ id, title, author }) => <BookCard title={title} author={author} key={id}/>)
  }

  return (
    <div className='container is-max-desktop'>
      {loading ? <div>Loading...</div> : bookCards()}
    </div>
  )
}

export default App
