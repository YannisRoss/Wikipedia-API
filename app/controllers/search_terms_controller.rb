class SearchTermsController < ApplicationController
    require './lib/assets/API_methods.rb'
    include APIMethods


    def create
        
        @search_term = SearchTerm.new(search_term_params)
        
        respond_to do |format|
            if @search_term.save
                articles = search(@search_term.body)
              format.html { redirect_to root_path, notice: "search_term was successfully created." }
              format.json { render :show, status: :created, location: @search_term }
            else
                format.html { redirect_to root_path,  alert: "search_term failed, #{@search_term.errors.full_messages.first}" , status: :unprocessable_entity }
                format.json { render json: @search_term.errors, status: :unprocessable_entity }
            end
          end
    end

    
    def search_term_params
        params.require(:search_term).permit(:body, :user_id)
            
    end
end
