describe('main page', () => {
  it('has the example text on it', () => {
    cy.visit('/')
    cy.contains('Hello, Rails 7 with ESBuild!')
  })
})
