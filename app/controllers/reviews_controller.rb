class ReviewsController < ApplicationController
  def index
  end
  
  def new
    @instructor = User.find(params[:instructor_id])
    @review = Review.new
  end
  
  def create
    @review = Review.new(from_user_id: current_user.id, to_user_id: params[:instructor_id], rate: review_params[:rate], comment: review_params[:comment])
    if @review.save
      flash[:success] = 'レビューが完了しました'
      redirect_to current_user
    else
      flash.now[:danger] = 'レビューできませんでした'
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
    def review_params
      params.require(:review).permit(:rate, :comment)
    end
end
