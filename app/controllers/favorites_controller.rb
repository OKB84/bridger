class FavoritesController < ApplicationController
  def create
    instructor = User.find(params[:favorite_id])
    current_user.favorite(instructor)
  end

  def destroy
    instructor = User.find(params[:favorite_id])
    current_user.unfavorite(instructor)
  end
end
