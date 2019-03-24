class ToppagesController < ApplicationController
  skip_before_action :require_login
  def index
    @latest_lesson = Lesson.last
    @second_latest_lesson = Lesson.last(2)[0]
    @third_latest_lesson = Lesson.last(3)[0]
  end
end
