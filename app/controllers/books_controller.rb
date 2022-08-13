class BooksController < ApplicationController
  before_action :authorize

  def index
    ordered_books = Book.left_joins(:rankings)
                        .select(:id, :title, :author)
                        .order(Ranking.arel_table[:position].asc, :read_at)

    render json: ordered_books.to_json
  end

  private

  def authorize
    head :unauthorized if logged_out?
  end
end
