class FavoritingsController < ApplicationController

  def index
    @favoritings = Favoriting.all
  end
  def create
    @favoriting = Favoriting.new(user_id: current_user.id, wiki_entry_id: params[:id])
        

        if @favoriting.save
          redirect_to root_path, notice: "favoriting was successfully created." 
        else
            redirect_to root_path,  alert: "favoriting failed, #{@favoriting.errors.full_messages.first}"
        end
      
  end

  def destroy
    @favoriting = Favoriting.where(user_id: current_user.id, wiki_entry_id: params[:id]).first
    if @favoriting.destroy
      redirect_to root_path, notice: "favoriting was successfully destroyed." 
    else
      redirect_to root_path,  alert: "favoriting destroy failed, #{favoriting.errors.full_messages.first}"
    end
  end
  
end
