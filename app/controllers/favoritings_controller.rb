class FavoritingsController < ApplicationController

  def create
    @favoriting = Favoriting.new(user_id: current_user.id, wiki_entry_id: params[:id])
        

        if @favoriting.save
          redirect_to root_path, notice: "favoriting was successfully created." 
        else
            redirect_to root_path,  alert: "favoriting failed, #{@favoriting.errors.full_messages.first}"
        end
      
  end

  def destroy
  end
  
end
