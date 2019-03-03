class CreateLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :lessons do |t|
      t.references :instructor, foreign_key: { to_table: :users }
      t.string :youtube_url1
      t.string :youtube_url2
      t.string :youtube_url3
      t.text :introduction
      t.text :advantage

      t.timestamps
    end
  end
end
