class CreateLessonPlans < ActiveRecord::Migration[5.0]
  def change
    create_table :lesson_plans do |t|
      t.references :lesson, foreign_key: true
      t.integer :minute
      t.string :location_broad
      t.string :location_narrow
      t.integer :price_yen

      t.timestamps
    end
  end
end
