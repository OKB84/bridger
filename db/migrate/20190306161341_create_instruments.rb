class CreateInstruments < ActiveRecord::Migration[5.0]
  def change
    create_table :instruments do |t|
      t.string :ins_name_ja
      t.string :ins_name_en

      t.timestamps
    end
  end
end
