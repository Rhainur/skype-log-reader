class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.string :speaker
      t.text :content

      t.timestamps
    end
  end
end
