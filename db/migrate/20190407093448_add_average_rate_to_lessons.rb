class AddAverageRateToLessons < ActiveRecord::Migration[5.0]
  def change
    add_column :lessons, :average_rate, :float
  end
end
