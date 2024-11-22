class AddImageUrlToTools < ActiveRecord::Migration[7.1]
  def change
    add_column :tools, :image_url, :string
  end
end
