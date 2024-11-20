class RemoveImagesFromUsersAndTools < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :image, :string
    remove_column :tools, :image, :string
  end
end
