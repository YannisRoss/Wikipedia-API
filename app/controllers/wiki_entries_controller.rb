class WikiEntriesController < ApplicationController

    def welcome
        @wiki_entries = WikiEntry.all
        @latest_entries = WikiEntry.all.last(10) unless WikiEntry.all.length < 10
    end

    def index
        @wiki_entries = WikiEntry.all
    end

    def show
        @wiki_entry = WikiEntry.find(params[:id])
    end
    def create(title = 'error', pageid = 0, wordcount = 0, snippet = 'error', fullurl ='error')
        
        @wiki_entry = WikiEntry.new(wiki_entry_params)
        
        respond_to do |format|
            if @wiki_entry.save
              format.html { redirect_to root_path, notice: "wiki_entry was successfully created. #{articles.length}" }
              format.json { render :show, status: :created, location: @wiki_entry }
            else
                format.html { redirect_to root_path,  alert: "wiki_entry failed, #{@wiki_entry.errors.full_messages.first}" , status: :unprocessable_entity }
                format.json { render json: @wiki_entry.errors, status: :unprocessable_entity }
            end
          end
    end


    
    def wiki_entry_params
        params.permit(:title, :pageid, :wordcount, :snippet, :fullurl)
            
    end

 
end
