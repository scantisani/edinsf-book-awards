class RankingsController < ApplicationController
  def create
    head :ok
  end

  private

  def ranking_params
    params.require(:order)
  end
end
