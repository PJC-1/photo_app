class CreatePictureTags < ActiveRecord::Migration
  def change
    create_table :picture_tags do |t|
      t.belongs_to :picture, index: true, foreign_key: true
      t.belongs_to :tag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
