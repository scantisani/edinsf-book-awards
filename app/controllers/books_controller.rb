class BooksController < ApplicationController
  def index
    render json: ordered_books.select(:id, :title, :author).to_json
  end

  private

  def ordered_books
    user_ranked_books = Book.joins(:rankings).where(rankings: {user: current_user})
    return Book.order(:read_at) if user_ranked_books.none?

    user_ranked_books.order(Ranking.arel_table[:position].asc)
  end
end
