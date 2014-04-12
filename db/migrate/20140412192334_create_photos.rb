class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :url
      t.string :lat
      t.string :long
      t.datetime :datetime

      t.timestamps
    end
  end
end
