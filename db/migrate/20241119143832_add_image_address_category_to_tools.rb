class AddImageAddressCategoryToTools < ActiveRecord::Migration[7.1]
  def change
    add_column :tools, :image, :string
    add_column :tools, :address, :string
    add_column :tools, :category, :string
  end
end
