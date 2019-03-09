class CreateUsersLanguages < ActiveRecord::Migration[5.0]
  def change
    create_table :users_languages do |t|
      t.references :user, foreign_key: true
      t.references :language, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :language_id], unique: true
    end
  end
end
