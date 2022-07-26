describe('main page', () => {
  const books = [
    { title: 'The Monk', author: 'Matthew Lewis' },
    { title: 'Plum Rains', author: 'Andromeda Romano-Lax' },
    { title: 'A Memory Called Empire', author: 'Arkady Martine' },
    { title: 'The Memory Police', author: 'Yoko Ogawa' },
    { title: 'Jonathan Strange & Mr Norrell', author: 'Susanna Clarke' },
    { title: 'Before the Coffee Gets Cold', author: 'Toshikazu Kawaguchi' },
    { title: 'Infinite Detail', author: 'Tim Maughan' },
    { title: 'The Affirmation', author: 'Christopher Priest' },
    { title: "Rocannon's World", author: 'Ursula K. le Guin' },
    { title: 'The Elementals', author: 'Michael McDowell' },
    { title: 'Civilwarland in Bad Decline', author: 'George Saunders' }
  ]

  it('displays the title and a card for each book', () => {
    cy.visit('/')

    cy.contains('Your Ranking')
    books.forEach(({ title, author }) => {
      cy.contains('.card', title).contains(author)
    })
  })

  describe('when getting books fails', () => {
    beforeEach(() => cy.intercept('GET', '/books*', { statusCode: 500 }))

    it('displays an error message', () => {
      cy.visit('/')
      cy.contains('Failed to load books')
    })
  })

  describe('reordering books', () => {
    beforeEach(() => cy.request('/cypress_rails_reset_state'))

    const dragCard = (sourceTitle: string, targetTitle: string): void => {
      cy.contains('.card', sourceTitle)
        .trigger('mousedown')

      cy.contains('.card', targetTitle)
        .trigger('mouseup', { animationDistanceThreshold: 20 })
    }

    const firstBookTitle = books[0].title
    const secondBookTitle = books[1].title

    it('can be done via drag and drop', () => {
      cy.visit('/')

      dragCard(firstBookTitle, secondBookTitle)

      cy.contains('.card', secondBookTitle)
        .next()
        .contains(firstBookTitle)
    })

    it('triggers the message "Saving" while saving, then "Saved" on success', () => {
      cy.visit('/')
      dragCard(firstBookTitle, secondBookTitle)

      cy.contains('Saving...')
      cy.contains('Saved')
    })

    describe('when saving the order fails', () => {
      beforeEach(() => cy.intercept('POST', '/rankings*', { statusCode: 500 }))

      it('displays an error message', () => {
        cy.visit('/')
        dragCard(firstBookTitle, secondBookTitle)

        cy.contains('Saving changes failed')
      })
    })
  })
})
