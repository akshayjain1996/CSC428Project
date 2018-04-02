class AddImageToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, image_id: :string
    add_column :photos, classification: :string
  end
end
