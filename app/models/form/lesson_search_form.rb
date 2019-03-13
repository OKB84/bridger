class Form::LessonSearchForm
  include ActiveModel::Model
  
  attr_accessor :name, :language_ids, :instrument_ids, :subject_ids, :location_broad_id
  
  def search
    rel = Lesson
    rel = rel.joins(:users).where(name: name) if name.present?
    rel = rel.joins(:users).joins(:users_languages).where(language_id: language_ids) if language_ids.present?
    rel = rel.joins(:available_instruments).where(instrument_id: instrument_ids) if instrument_ids.present?
    rel = rel.joins(:available_subjects).where(subject_id: subject_ids) if subject_ids.present?
    rel = rel.joins(:lesson_plans).where(location_broad_id: location_broad_id) if location_broad_id.present?
  end
end