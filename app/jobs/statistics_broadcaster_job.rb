class StatisticsBroadcasterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    puts 'sidekiq job started'
    wiki_entries = WikiEntry.all
    ActionCable.server.broadcast 'room', {
      entries: wiki_entries, 
      terms: SearchTerm.all, 
      wordcount_max_min: [wiki_entries.order(:wordcount).limit(1).first.title, wiki_entries.order(wordcount: :desc).limit(1).first.title],
      biggest_title: wiki_entries.sort_by{|entry| entry.title}.first.title,
      lowest_levenshtein: wiki_entries.sort_by{|entry| entry.levenshtein_distance(entry.title, entry.search_term.body)}.first.title,
      lowest_levenshtein_term: wiki_entries.sort_by{|entry| entry.levenshtein_distance(entry.title, entry.search_term.body)}.first.search_term.body,
  
  }
  end
end
