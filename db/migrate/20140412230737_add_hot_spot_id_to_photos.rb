class AddHotSpotIdToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :hot_spot_id, :integer
  end
end
