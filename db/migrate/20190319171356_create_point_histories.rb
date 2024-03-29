class CreatePointHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :point_histories do |t|
      t.references :from_user, foreign_key: { to_table: :users }
      t.references :to_user, foreign_key: { to_table: :users }
      t.integer :amount

      t.timestamps
    end
  end
end
