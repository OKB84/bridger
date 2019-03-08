class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit]
  skip_before_action :require_login, only: [:index, :show]
  
  def index
    @lessons = Lesson.all
  end

  def show
    @url1 = @lesson.youtube_url1.gsub('https://www.youtube.com/watch?v=', '')
    @url2 = @lesson.youtube_url2.gsub('https://www.youtube.com/watch?v=', '')
    @url3 = @lesson.youtube_url3.gsub('https://www.youtube.com/watch?v=', '')
    
    instruments = []
    @lesson.instrument_ids.each do |id|
      instruments << Instrument.find(id).ins_name_ja
    end
    @instrument_names = instruments.join('、')
    
    subjects = []
    @lesson.subject_ids.each do |id|
      subjects << Subject.find(id).subj_name_ja
    end
    @subject_names = subjects.join('、')    
  end

  def new
    if lesson = Lesson.find_by(instructor_id: current_user.id)
      redirect_to lesson_path(lesson) #editアクションが完成したらそちらに飛ばす
    else
      @lesson = Lesson.new
      @lesson.lesson_plans.build
    end
  end

  def create
    @lesson = Lesson.new(lesson_params)
    if @lesson.save
      flash[:success] = 'レッスン情報を登録しました'
      redirect_to lesson_url(@lesson.id)
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
  
  private
  
  def set_lesson
    @lesson = Lesson.find(params[:id])
  end
  
  def lesson_params
    params.require(:lesson).permit(:youtube_url1, :youtube_url2, :youtube_url3, :biography, :advantage, :instructor_id, lesson_plans_attributes: [:id, :minute, :location_broad, :location_narrow, :price_yen, :destroy], instrument_ids: [], subject_ids: [])
  end
  
  def correct_user
    
  end
end
