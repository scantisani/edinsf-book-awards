describe('The results page', () => {
  beforeEach(() => cy.login())

  it('can be visited by clicking the "Results" tab', () => {
    cy.visit('/')

    cy.contains('Results').click()
  })
})
