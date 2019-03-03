class RenameIntroductionColumnToLessons < ActiveRecord::Migration[5.0]
  def change
    rename_column :lessons, :introduction, :biography
  end
end
