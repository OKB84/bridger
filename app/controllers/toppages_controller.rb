class ToppagesController < ApplicationController
  skip_before_action :require_login
  include LessonsHelper
  
  def index
    @latest_lesson = Lesson.last
    @second_latest_lesson = Lesson.last(2)[0]
    @third_latest_lesson = Lesson.last(3)[0]
    @top_rated_lessons = Lesson.all.order(average_rate: "DESC").limit(6)
  end
end
