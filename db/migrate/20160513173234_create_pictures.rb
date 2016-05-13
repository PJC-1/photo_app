class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :pic_img

      t.timestamps null: false
    end
  end
end
