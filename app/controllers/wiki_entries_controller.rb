class WikiEntriesController < ApplicationController

    def index
        @wiki_entries = WikiEntry.all
    end

    
end
