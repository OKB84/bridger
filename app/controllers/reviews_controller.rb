class ReviewsController < ApplicationController
  def index
  end
  
  def new
    @instructor = User.find(params[:instructor_id])
    @review = Review.new
  end
  
  def create
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
end
