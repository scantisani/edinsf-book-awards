class AddUserIdToRankings < ActiveRecord::Migration[7.0]
  def change
    change_table(:rankings, bulk: true) do |t|
      t.belongs_to :user, foreign_key: true
    end
    add_index :rankings, [:book_id, :user_id], unique: true
  end
end
