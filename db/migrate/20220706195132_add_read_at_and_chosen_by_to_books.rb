class AddReadAtAndChosenByToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :read_at, :date, null: false
    add_column :books, :chosen_by, :string, null: false
  end
end
