class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :default_price
      t.string :unit

      t.timestamps
    end
  end
end
