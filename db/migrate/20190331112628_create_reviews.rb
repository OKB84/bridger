class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.references :from_user, foreign_key: { to_table: :users }
      t.references :to_user, foreign_key: { to_table: :users }
      t.integer :rate
      t.text :comment

      t.timestamps
      
      t.index [:from_user_id, :to_user_id], unique: true
    end
  end
end
