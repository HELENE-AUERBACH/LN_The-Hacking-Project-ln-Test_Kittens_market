class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.string :img_url

      t.timestamps
    end
  end
end
