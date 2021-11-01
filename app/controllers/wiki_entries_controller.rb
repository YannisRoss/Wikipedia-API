class WikiEntriesController < ApplicationController

    def new(title, pageid, wordcount, snippet, fullurl)
        @title = title
        @pageid = pageid
        @wordcount = wordcount
          if snippet.length > 50
              @snippet = snippet[0..50] + '...'
          else
              @snippet = snippet
          end
        @fullurl = fullurl
    end
  
    def index
        @wiki_entries = WikiEntry.all
    end

    
end
