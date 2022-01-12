class WikiEntriesController < ApplicationController

    def welcome
        @wiki_entries = WikiEntry.all
        @latest_entries = WikiEntry.all.last(10)  #unless WikiEntry.all.length < 10
        if params[:sort_factor]
            case params[:sort_factor]
            when 'title'
                @latest_entries = @latest_entries.sort_by{|entry| entry.title} 
            when 'wordcount'
                @latest_entries = @latest_entries.sort_by{|entry| entry.wordcount} 
            when 'levenshtein'
                @latest_entries = @latest_entries.sort_by{|entry| entry.levenshtein_distance(entry.title, entry.search_term.body)} 
            when 'favorites'
                @latest_entries = @latest_entries.sort_by{|entry| entry.favoritees.length}.reverse
            else    
            end
        end

        @latest_terms = SearchTerm.all.last(10)
        if params[:term_factor]
            case params[:term_factor]
            when 'alphabetically'
                @latest_terms = @latest_terms.sort_by{|term| term.body} 
            when 'entries'
                @latest_terms = @latest_terms.sort_by{|term| term.wiki_entries.length} 
            else    
            end
        end

        @top_active_users = User.all.sort_by{|user| user.activity_factor}.last(5).reverse


    end

    def index
        @wiki_entries = WikiEntry.all

        if params[:offset]
            case params[:offset]
            when '10'
                @wiki_entries = @wiki_entries.first(10) 
            when '50'
                @wiki_entries = @wiki_entries.first(50) 
            when '100'
                @wiki_entries = @wiki_entries.first(100)
            else    
            end
        end
    end

    def show
        @wiki_entry = WikiEntry.find(params[:id])

        @wiki_entry = sanitize_snippet(@wiki_entry)
        
    end

    def sanitize_snippet(wiki_entry)

        wiki_entry.snippet = ActionView::Base.full_sanitizer.sanitize(wiki_entry.snippet)

        wiki_entry
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
