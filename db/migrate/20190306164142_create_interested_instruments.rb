class CreateInterestedInstruments < ActiveRecord::Migration[5.0]
  def change
    create_table :interested_instruments do |t|
      t.references :user, foreign_key: true
      t.references :instrument, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :instrument_id], unique: true
    end
  end
end
