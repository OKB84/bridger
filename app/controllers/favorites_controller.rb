class FavoritesController < ApplicationController
  def create
    instructor = User.find(params[:favorite_id])
    unless current_user.favorite?(instructor)
      current_user.favorite(instructor)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
      @lessons.reload
    end
  end

  def destroy
    instructor = User.find(params[:favorite_id])
    current_user.unfavorite(instructor)
  end
end
