class CreateCryptocurrencies < ActiveRecord::Migration[8.0]
  def change
    create_table :cryptocurrencies do |t|
      t.string :name
      t.decimal :price
      t.boolean :favorite, default: false

      t.timestamps
    end
  end
end
