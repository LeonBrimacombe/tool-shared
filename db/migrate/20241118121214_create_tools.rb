class CreateTools < ActiveRecord::Migration[7.1]
  def change
    create_table :tools do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.date :available_from
      t.date :available_until
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
