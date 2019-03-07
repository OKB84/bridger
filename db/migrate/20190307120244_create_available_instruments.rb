class CreateAvailableInstruments < ActiveRecord::Migration[5.0]
  def change
    create_table :available_instruments do |t|
      t.references :lesson, foreign_key: true
      t.references :instrument, foreign_key: true

      t.timestamps
      
      t.index [:lesson_id, :instrument_id], unique: true
    end
  end
end
