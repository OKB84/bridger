class CreateAvailableSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :available_subjects do |t|
      t.references :lesson, foreign_key: true
      t.references :subject, foreign_key: true

      t.timestamps
      
      t.index [:lesson_id, :subject_id], unique: true
    end
  end
end
