class AddClassificationToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :classification, :string
  end
end
