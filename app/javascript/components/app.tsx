import * as React from 'react'

interface AppProps {
  arg: string;
}

const App = ({ arg }: AppProps) => {
  return <div className={'notification is-primary'}>{`Hello, ${arg}!`}</div>
}

export default App
