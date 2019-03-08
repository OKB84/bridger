class CreateSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :subjects do |t|
      t.string :subj_name_ja
      t.string :subj_name_en

      t.timestamps
    end
  end
end
