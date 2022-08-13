class RankingsController < ApplicationController
  def create
    return head :bad_request unless valid_request?

    create_or_update_rankings!
  rescue ActiveRecord::RecordInvalid, ActionController::ParameterMissing
    head :unprocessable_entity
  end

  private

  def ordered_book_ids
    params.require(:order)
  end

  # @return [Boolean] true if ordered IDs contain no duplicates, false otherwise
  def valid_request?
    !ordered_book_ids.uniq! # Array#uniq! returns nil if there are no duplicates
  end

  def create_or_update_rankings!
    rankings = Ranking.where(book_id: ordered_book_ids)

    if rankings.none?
      create_new_rankings!
    else
      update_current_rankings!(rankings)
    end
  end

  def create_new_rankings!
    Ranking.create!(new_ranking_attributes)
  end

  def new_ranking_attributes
    ordered_book_ids.map.with_index do |book_id, index|
      {book_id: book_id, position: index}
    end
  end

  def update_current_rankings!(current_rankings)
    ranking_hashes = as_hashes(current_rankings)
    ranking_updates = extract_position_updates(ranking_hashes)

    Ranking.update!(ranking_updates.keys, ranking_updates.values)
  end

  def as_hashes(rankings)
    rankings.pluck(:id, :book_id, :position)
            .to_h { |id, book_id, position| [id, {book_id: book_id, position: position}] }
  end

  def extract_position_updates(ranking_hashes)
    ranking_hashes.transform_values do |current_ranking|
      new_position = ordered_book_ids.index(current_ranking[:book_id])
      next if new_position == current_ranking[:position]

      current_ranking.merge(position: new_position)
    end.compact
  end
end
