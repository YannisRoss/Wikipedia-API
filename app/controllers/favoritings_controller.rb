class FavoritingsController < ApplicationController
  def index
    @favoritings = Favoriting.all
  end

  def create
    @favoriting = Favoriting.new(user_id: current_user.id, wiki_entry_id: params[:id])

    if @favoriting.save
      redirect_back fallback_location: root_path, notice: 'Item successfully added to favorites.'
    else
      redirect_back fallback_location: root_path, alert: "Favorite addition failed, #{@favoriting.errors.full_messages.first}"
    end
  end

  def destroy
    @favoriting = Favoriting.where(user_id: current_user.id, wiki_entry_id: params[:id]).first
    if @favoriting.destroy
      redirect_back fallback_location: root_path, notice: 'Item successfully removed from favorites.'
    else
      redirect_back fallback_location: root_path,
                    alert: "Favorite removal failed, #{favoriting.errors.full_messages.first}"
    end
  end
end
