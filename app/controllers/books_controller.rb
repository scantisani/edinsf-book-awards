class BooksController < ApplicationController
  def index
    ordered_books = Book.left_joins(:rankings)
                        .select(:id, :title, :author)
                        .order(Ranking.arel_table[:position].asc, :read_at)

    render json: ordered_books.to_json
  end
end
