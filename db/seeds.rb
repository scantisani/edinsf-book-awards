User.create!(name: "Scott", uuid: "f172ffd1-4d06-4a3b-925c-30bec3bbf60c")

Book.create!([
  {title: "The Monk", author: "Matthew Lewis", published_at: Time.utc(1796).getlocal, read_at: Time.utc(2021, 1), chosen_by: "Amy"},
  {title: "Plum Rains", author: "Andromeda Romano-Lax", published_at: Time.utc(2018), read_at: Time.utc(2021, 2), chosen_by: "Scott"},
  {title: "A Memory Called Empire", author: "Arkady Martine", published_at: Time.utc(2019), read_at: Time.utc(2021, 3), chosen_by: "Bruno"},
  {title: "The Memory Police", author: "Yoko Ogawa", published_at: Time.utc(1994), read_at: Time.utc(2021, 4), chosen_by: "Turner"},
  {title: "Jonathan Strange & Mr Norrell", author: "Susanna Clarke", published_at: Time.utc(2004), read_at: Time.utc(2021, 5), chosen_by: "Dorothy"},
  {title: "Before the Coffee Gets Cold", author: "Toshikazu Kawaguchi", published_at: Time.utc(2015), read_at: Time.utc(2021, 6), chosen_by: "Joe"},
  {title: "Infinite Detail", author: "Tim Maughan", published_at: Time.utc(2019), read_at: Time.utc(2021, 7), chosen_by: "Katy"},
  {title: "The Affirmation", author: "Christopher Priest", published_at: Time.utc(1981), read_at: Time.utc(2021, 8), chosen_by: "Rory"},
  {title: "Rocannon's World", author: "Ursula K. le Guin", published_at: Time.utc(1966), read_at: Time.utc(2021, 9), chosen_by: "Tony"},
  {title: "The Elementals", author: "Michael McDowell", published_at: Time.utc(1981), read_at: Time.utc(2021, 10), chosen_by: "Kate"},
  {title: "Civilwarland in Bad Decline", author: "George Saunders", published_at: Time.utc(1996), read_at: Time.utc(2021, 11), chosen_by: "Jer"}
])
