import * as React from 'react'
import BookList from './book_list'
import { useEffect, useState } from 'react'
import LoadStatus from '../interfaces/load_status'
import { Book } from '../interfaces/book'
import { getResults } from '../lib/requests'

const Results = (): JSX.Element => {
  const [loadStatus, setLoadStatus] = useState(LoadStatus.LOADING)
  const [results, setResults] = useState<Book[]>([])

  useEffect(() => {
    getResults()
      .then(response => {
        setResults(response.data)
        setLoadStatus(LoadStatus.SUCCESS)
      })
      .catch(() => {
        setLoadStatus(LoadStatus.ERROR)
      })
  }, [])

  switch (loadStatus) {
    case LoadStatus.LOADING: return <div>Loading...</div>
    case LoadStatus.SUCCESS: return <BookList books={results} />
    case LoadStatus.ERROR: return <div>Failed to load results.</div>
  }
}

export default Results
