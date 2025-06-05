class CreateRandomSelections < ActiveRecord::Migration[8.0]
  def change
    create_table :random_selections do |t|
      t.string :name
      t.decimal :price

      t.timestamps
    end
  end
end
