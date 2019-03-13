class LessonSearchController
  def index
    @form = LessonSearch.new(params.require(:lesson_search))
  end
end