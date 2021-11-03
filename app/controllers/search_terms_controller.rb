class SearchTermsController < ApplicationController
    require './lib/assets/API_methods.rb'
    include APIMethods

    def index
        @search_terms = SearchTerm.all
    end

    def create
        
        @search_term = SearchTerm.new(search_term_params)
        
        respond_to do |format|
            if @search_term.save
                search(@search_term)
              format.html { redirect_to root_path, notice: "search_term was successfully created." }
              format.json { render :show, status: :created, location: @search_term }
              ActionCable.server.broadcast 'room', {entries_and_terms: [WikiEntry.all, SearchTerm.all]}

            else
                format.html { redirect_to root_path,  alert: "search_term failed, #{@search_term.errors.full_messages.first}" , status: :unprocessable_entity }
                format.json { render json: @search_term.errors, status: :unprocessable_entity }
            end
          end
    end

    private
    def search_term_params
        params.require(:search_term).permit(:body, :user_id)
            
    end



end
