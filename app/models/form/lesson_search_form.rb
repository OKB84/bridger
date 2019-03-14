class Form::LessonSearchForm
  include ActiveModel::Model
  
  attr_accessor :name, :language_ids, :instrument_ids, :subject_ids, :location_broad_id
  
  def search
    rel = Lesson
    rel = Lesson.joins(:instructor).where(users: { name: name }) if name.present?
    rel = rel.joins(instructor: :users_languages).where(users_languages: { language_id: language_ids }) if language_ids.present?
    rel
  end
end