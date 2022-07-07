class AddUniqueIndexToReadAtOnBooks < ActiveRecord::Migration[7.0]
  def change
    add_index(:books, :read_at, unique: true)
  end
end
