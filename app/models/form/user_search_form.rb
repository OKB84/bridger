class Form::UserSearchForm
  include ActiveModel::Model
  
  attr_accessor :language_ids, :instrument_ids, :subject_ids
  
  def search
    rel = User.all
    rel = rel.joins(:interested_instruments).where(interested_instruments: { instrument_id: instrument_ids }) if instrument_ids.present?
    rel = rel.joins(:interested_instruments_subjects).where(interested_subjects: { subject_id: subject_ids }) if subject_ids.present?
    rel = rel.joins(:users_languages).where(users_languages: { language_id: language_ids }) if language_ids.present?
    rel
  end
end