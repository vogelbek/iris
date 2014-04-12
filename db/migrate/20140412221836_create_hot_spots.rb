class CreateHotSpots < ActiveRecord::Migration
  def change
    create_table :hot_spots do |t|
      t.string :city
      t.string :lat
      t.string :long

      t.timestamps
    end
  end
end
