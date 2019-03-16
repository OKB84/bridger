class Form::LessonSearchForm
  include ActiveModel::Model
  
  attr_accessor :name, :language_ids, :instrument_ids, :subject_ids, :location_broad
  
  validates :name, presence: true #問題なければ消す
  
  def search
    rel = Lesson.all
    rel = Lesson.joins(:instructor).where(users: { name: name }) if name.present?
    rel = rel.joins(:available_instruments).where(available_instruments: { instrument_id: instrument_ids }) if instrument_ids.present?
    rel = rel.joins(:available_subjects).where(available_subjects: { subject_id: subject_ids }) if subject_ids.present?
    rel = rel.joins(:lesson_plans).where(lesson_plans: { location_broad: location_broad }) if location_broad.present?
    rel = rel.joins(instructor: :users_languages).where(users_languages: { language_id: language_ids }) if language_ids.present?
    rel
  end
end