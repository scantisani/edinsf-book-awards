class CreateRankings < ActiveRecord::Migration[7.0]
  def change
    create_table :rankings do |t|
      t.belongs_to :book, foreign_key: true
      t.integer :position, null: false

      t.timestamps
    end
  end
end
