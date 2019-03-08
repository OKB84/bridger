class CreateInterestedSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :interested_subjects do |t|
      t.references :user, foreign_key: true
      t.references :subject, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :subject_id], unique: true
    end
  end
end
