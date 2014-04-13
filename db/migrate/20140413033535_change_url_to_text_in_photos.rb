class ChangeUrlToTextInPhotos < ActiveRecord::Migration
  def change
    change_column :photos, :url, :text
  end
end
