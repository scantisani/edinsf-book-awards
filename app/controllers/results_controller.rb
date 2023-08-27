class ResultsController < ApplicationController
  def index
    render json: results.select(:id, :title, :author).to_json
  end

  private

  def results
    Book.order(:read_at)
  end
end
