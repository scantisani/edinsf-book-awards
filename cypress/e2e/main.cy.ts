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
})
