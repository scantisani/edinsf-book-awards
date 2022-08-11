describe('login via URL', () => {
  describe('when the UUID is valid', () => {
    it("shows the user's rankings", () => {
      cy.visit('/users/f172ffd1-4d06-4a3b-925c-30bec3bbf60c')
      cy.contains('Your Ranking')
    })
  })

  describe('when the UUID is not valid', () => {
    it('redirects to the 404 page', () => {
      cy.visit('/users/1', { failOnStatusCode: false })
      cy.contains("The page you were looking for doesn't exist")
    })
  })
})
