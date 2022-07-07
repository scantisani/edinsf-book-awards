class AddReadAtAndChosenByToBooks < ActiveRecord::Migration[7.0]
  def change
    change_table(:books, bulk: true) do |t|
      t.column :read_at, :date, null: false, default: -> { "NOW()" }
      t.column :chosen_by, :string, null: false, default: "Unknown"
    end
  end
end
