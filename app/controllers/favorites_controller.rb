class FavoritesController < ApplicationController
  def create
    @instructor = User.find(params[:favorite_id])
    unless current_user.favorite?(@instructor)
      current_user.favorite(@instructor)
    end
    @instructor.reload
  end

  def destroy
    @instructor = User.find(params[:favorite_id])
    current_user.unfavorite(@instructor)
    @instructor.reload
  end
end
