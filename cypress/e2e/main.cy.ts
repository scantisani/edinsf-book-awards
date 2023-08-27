import BOOKS from '../support/books'

describe('main page', () => {
  beforeEach(() => cy.login())

  it('displays the title and a card for each book', () => {
    cy.visit('/')

    cy.contains('Your Ranking')
    BOOKS.forEach(({ title, author }) => {
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

    const firstBookTitle = BOOKS[0].title
    const secondBookTitle = BOOKS[1].title

    it('can be done via drag and drop', () => {
      cy.visit('/')

      dragCard(firstBookTitle, secondBookTitle)

      cy.contains('.card', secondBookTitle).contains('#1')
      cy.contains('.card', firstBookTitle).contains('#2')
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

    it('persists across refreshes', () => {
      cy.visit('/')
      dragCard(firstBookTitle, secondBookTitle)

      // wait for the request to finish
      cy.contains('Saved')

      cy.reload()
      cy.contains('.card', secondBookTitle).contains('#1')
      cy.contains('.card', firstBookTitle).contains('#2')
    })
  })
})
