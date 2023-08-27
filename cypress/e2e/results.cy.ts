import BOOKS from '../support/books'

describe('The results page', () => {
  beforeEach(() => cy.login())

  it('can be visited by clicking the "Results" tab', () => {
    cy.visit('/')

    cy.contains('Results').click()
  })

  describe('when on the Results page', () => {
    beforeEach(() => {
      cy.visit('/')
      cy.contains('Results').click()
    })

    it('displays all the books', () => {
      BOOKS.forEach(({ title, author }) => {
        cy.contains('.card', title).contains(author)
      })
    })
  })
})
