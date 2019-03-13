class LessonSearchFormController < ApplicationController
  def index
    @form = Form::LessonSearchForm.new(params[:search])
    @instructors =
  end
  
  private
  
  def lesson_search_form_params
    params.require(:lesson_search_form).permit(:name, :location_broad_id, language_ids: [], instrument_ids: [], subject_ids: [])
  end
end