class BooksController < ApplicationController
  def index
    render json: Book.select(:id, :title, :author).to_json
  end
end
