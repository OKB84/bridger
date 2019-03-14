class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update]
  skip_before_action :require_login, only: [:index, :show]
  
  def index
    if params[:search].present?
      @search_form = Form::LessonSearchForm.new(lesson_search_form_params)
      if @search_form.search == Lesson
        @search_form = Form::LessonSearchForm.new
        @lessons = Lesson.all
      else
        @lessons = []
        @search_form.search.ids.each do |id|
          @lessons << Lesson.find(id)
        end
      end
    else
      @search_form = Form::LessonSearchForm.new
      @lessons = Lesson.all
    end
  end

  def show
    @url1 = @lesson.youtube_url1.gsub('https://www.youtube.com/watch?v=', '')
    @url2 = @lesson.youtube_url2.gsub('https://www.youtube.com/watch?v=', '')
    @url3 = @lesson.youtube_url3.gsub('https://www.youtube.com/watch?v=', '')
    
    @instruments = @lesson.instruments
    @subjects = @lesson.subjects
    @languages = @lesson.instructor.languages
  end

  def new
    if lesson = Lesson.find_by(instructor_id: current_user.id)
      redirect_to edit_lesson_url(lesson)
    else
      @lesson = Lesson.new
      @lesson.lesson_plans.build
    end
  end

  def create
    @lesson = Lesson.new(lesson_params)
    if @lesson.save
      flash[:success] = 'レッスン情報を登録しました'
      redirect_to @lesson
    else
      flash.now[:danger] = 'レッスン情報の登録に失敗しました'
      render :new
    end
  end

  def edit
    unless @lesson == Lesson.find_by(instructor_id: current_user.id)
      redirect_to user_path(current_user)
    end
  end
  
  def update
    if @lesson.update(lesson_params)
      flash[:success] = 'レッスン情報を更新しました。'
      redirect_to @lesson
    else
      flash.now[:danger] = 'レッスン情報の更新に失敗しました。'
      render :edit
    end
  end
  
  private
  
  def set_lesson
    @lesson = Lesson.find(params[:id])
  end
  
  def lesson_params
    params.require(:lesson).permit(:youtube_url1, :youtube_url2, :youtube_url3, :biography, :advantage, :instructor_id, lesson_plans_attributes: [:id, :minute, :location_broad, :location_narrow, :price_yen, :destroy], instrument_ids: [], subject_ids: [])
  end
  
  def lesson_search_form_params
    params.require(:search).permit(:name, instrument_ids: [], language_ids: [])
  end
end
