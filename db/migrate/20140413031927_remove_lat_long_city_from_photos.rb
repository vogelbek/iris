class RemoveLatLongCityFromPhotos < ActiveRecord::Migration
  def change
    remove_column :photos, :lat, :string
    remove_column :photos, :long, :string
    remove_column :photos, :city, :string
  end
end
