class LessonsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]
  
  def index
    @lessons = Lesson.all
  end

  def show
    @lesson = Lesson.find(params[:id])
    @url1 = @lesson.youtube_url1.gsub('https://www.youtube.com/watch?v=', '')
    @url2 = @lesson.youtube_url2.gsub('https://www.youtube.com/watch?v=', '')
    @url3 = @lesson.youtube_url3.gsub('https://www.youtube.com/watch?v=', '')
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
    @lesson = Lesson.find(params[:id])
    unless @lesson == Lesson.find_by(instructor_id: current_user.id)
      redirect_to user_path(current_user)
    end
  end
  
  private
  
  def lesson_params
    params.require(:lesson).permit(:youtube_url1, :youtube_url2, :youtube_url3, :biography, :advantage, :instructor_id, lesson_plans_attributes: [:id, :minute, :location_broad, :location_narrow, :price_yen, :destroy])
  end
end
