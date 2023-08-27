scott = User.create!(name: "Scott", uuid: "f172ffd1-4d06-4a3b-925c-30bec3bbf60c")
tony = User.create!(name: "Tony", uuid: "ce4dda35-848a-4e1f-96f3-cc75be4b24f4")
rory = User.create!(name: "Rory", uuid: "e91585a8-b9cf-40ea-bbe7-d04635dc6f7d")
hayley = User.create!(name: "Hayley", uuid: "48f44dd7-812f-43c2-8d61-d1efcdfdcedc")

monk = Book.create!(title: "The Monk", author: "Matthew Lewis", published_at: Time.utc(1796).getlocal, read_at: Time.utc(2021, 1), chosen_by: "Amy")
plum_rains = Book.create!(title: "Plum Rains", author: "Andromeda Romano-Lax", published_at: Time.utc(2018), read_at: Time.utc(2021, 2), chosen_by: "Scott")
memory_called_empire = Book.create!(title: "A Memory Called Empire", author: "Arkady Martine", published_at: Time.utc(2019), read_at: Time.utc(2021, 3), chosen_by: "Bruno")
memory_police = Book.create!(title: "The Memory Police", author: "Yoko Ogawa", published_at: Time.utc(1994), read_at: Time.utc(2021, 4), chosen_by: "Turner")
jonathan_strange = Book.create!(title: "Jonathan Strange & Mr Norrell", author: "Susanna Clarke", published_at: Time.utc(2004), read_at: Time.utc(2021, 5), chosen_by: "Dorothy")
before_the_coffee = Book.create!(title: "Before the Coffee Gets Cold", author: "Toshikazu Kawaguchi", published_at: Time.utc(2015), read_at: Time.utc(2021, 6), chosen_by: "Joe")
infinite_detail = Book.create!(title: "Infinite Detail", author: "Tim Maughan", published_at: Time.utc(2019), read_at: Time.utc(2021, 7), chosen_by: "Katy")
affirmation = Book.create!(title: "The Affirmation", author: "Christopher Priest", published_at: Time.utc(1981), read_at: Time.utc(2021, 8), chosen_by: "Rory")
rocannons_world = Book.create!(title: "Rocannon's World", author: "Ursula K. le Guin", published_at: Time.utc(1966), read_at: Time.utc(2021, 9), chosen_by: "Tony")
elementals = Book.create!(title: "The Elementals", author: "Michael McDowell", published_at: Time.utc(1981), read_at: Time.utc(2021, 10), chosen_by: "Kate")
civilwarland = Book.create!(title: "Civilwarland in Bad Decline", author: "George Saunders", published_at: Time.utc(1996), read_at: Time.utc(2021, 11), chosen_by: "Jer")

scott.rankings.create!([
  {book: monk, position: 0},
  {book: plum_rains, position: 1},
  {book: memory_called_empire, position: 2},
  {book: memory_police, position: 3},
  {book: jonathan_strange, position: 4},
  {book: before_the_coffee, position: 5},
  {book: infinite_detail, position: 6},
  {book: affirmation, position: 7},
  {book: rocannons_world, position: 8},
  {book: elementals, position: 9},
  {book: civilwarland, position: 10}
])

tony.rankings.create!([
  {book: civilwarland, position: 0},
  {book: elementals, position: 1},
  {book: rocannons_world, position: 2},
  {book: affirmation, position: 3},
  {book: infinite_detail, position: 4},
  {book: before_the_coffee, position: 5},
  {book: jonathan_strange, position: 6},
  {book: memory_police, position: 7},
  {book: memory_called_empire, position: 8},
  {book: plum_rains, position: 9},
  {book: monk, position: 10}
])

rory.rankings.create!([
  {book: rocannons_world, position: 0},
  {book: plum_rains, position: 1},
  {book: monk, position: 2},
  {book: memory_police, position: 3},
  {book: memory_called_empire, position: 4},
  {book: jonathan_strange, position: 5},
  {book: infinite_detail, position: 6},
  {book: elementals, position: 7},
  {book: civilwarland, position: 8},
  {book: before_the_coffee, position: 9},
  {book: affirmation, position: 10}
])

hayley.rankings.create!([
  {book: affirmation, position: 0},
  {book: before_the_coffee, position: 1},
  {book: civilwarland, position: 2},
  {book: elementals, position: 3},
  {book: infinite_detail, position: 4},
  {book: jonathan_strange, position: 5},
  {book: memory_called_empire, position: 6},
  {book: memory_police, position: 7},
  {book: monk, position: 8},
  {book: plum_rains, position: 9},
  {book: rocannons_world, position: 10}
])
