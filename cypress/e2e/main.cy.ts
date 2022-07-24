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

  it('displays a card for each book', () => {
    cy.visit('/')

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
    const dragCard = (sourceTitle: string, targetTitle: string): void => {
      cy.contains('.card', sourceTitle)
        .trigger('mousedown')

      cy.contains('.card', targetTitle)
        .trigger('mouseup')
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

    it('triggers a call to the `/rankings` endpoint', () => {
      cy.visit('/')
      cy.intercept('POST', '/rankings*').as('createRanking')

      dragCard(firstBookTitle, secondBookTitle)

      cy.wait('@createRanking')
        .its('request.body.order')
        .should('have.ordered.members', [2, 1, 3, 4, 5, 6, 7, 8, 9, 10, 11])
    })
  })
})
