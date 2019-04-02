class ReviewsController < ApplicationController
  def index
  end
  
  def new
    @instructor = User.find(params[:instructor_id])
    #以下のリダイレクト処理はbefore actionとした方が良いかも
    if current_user.taught_by?(@instructor)
      @review = Review.new
    else
      redirect_to current_user
    end
  end
  
  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:success] = 'レビューが完了しました'
      redirect_to current_user
    else
      flash.now[:danger] = 'レビューできませんでした'
      @instructor = User.find(review_params[:to_user_id])
      render :new
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
      params.require(:review).permit(:from_user_id, :to_user_id, :rate, :comment)
    end
end
