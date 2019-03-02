class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :send_user, foreign_key: { to_table: :users }
      t.references :receive_user, foreign_key: { to_table: :users }
      t.string :content

      t.timestamps
    end
  end
end
