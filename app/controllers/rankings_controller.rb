class RankingsController < ApplicationController
  def create
    Ranking.destroy_all
    Ranking.create!(ranking_attributes)
  rescue ActiveRecord::RecordInvalid
    head :unprocessable_entity
  end

  private

  def order_array_param
    params.require(:order)
  end

  def ranking_attributes
    order_array_param.map.with_index do |book_id, index|
      {book_id: book_id, position: index}
    end
  end
end
