import * as React from 'react'
import SaveStatus from '../interfaces/save_status'
import { IconCloudOff, IconRocket } from '@tabler/icons'

const SaveIndicator = ({ saveStatus }: { saveStatus: SaveStatus }): JSX.Element => {
  const Saving = (): JSX.Element => {
    return (
      <span className="icon-text">
        <span>Saving...</span>
        <span className="icon">
          <span className="spinning-circle ml-2"></span>
        </span>
      </span>
    )
  }

  const Saved = (): JSX.Element => {
    return (
      <span className="icon-text">
        <span className="has-text-centered">Saved!</span>
        <span className="icon has-text-success">
          <IconRocket />
        </span>
      </span>
    )
  }

  const Error = (): JSX.Element => {
    return (
      <span className="icon-text">
        <span>Couldn&apos;t connect to the server.</span>
        <span className="icon has-text-danger">
          <IconCloudOff />
        </span>
      </span>
    )
  }

  switch (saveStatus) {
    case SaveStatus.INITIAL: return <></>
    case SaveStatus.SAVING: return <Saving />
    case SaveStatus.SAVED: return <Saved />
    case SaveStatus.ERROR: return <Error />
  }
}

export default SaveIndicator
