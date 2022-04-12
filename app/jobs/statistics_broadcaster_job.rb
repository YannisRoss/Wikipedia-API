# frozen_string_literal: true

class StatisticsBroadcasterJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    wiki_entries = WikiEntry.all
    search_term = SearchTerm.last

    statistics = {
      entries: wiki_entries,
      terms: SearchTerm.all,
      wordcount_max_min: nil,
      biggest_title: nil,
      lowest_levenshtein: nil,
      lowest_levenshtein_term: nil
    }

    unless wiki_entries.empty?

      statistics[:wordcount_max_min] =
        wiki_entries.order(:wordcount).limit(1).first.title, wiki_entries.order(wordcount: :desc).limit(1).first.title
      statistics[:biggest_title] = wiki_entries.min_by(&:title).title
      statistics[:lowest_levenshtein] = wiki_entries.min_by do |entry|
        entry.levenshtein_distance(entry.title, entry.search_term.body)
      end.title
      statistics[:lowest_levenshtein_term] = wiki_entries.min_by do |entry|
        entry.levenshtein_distance(entry.title, entry.search_term.body)
      end.search_term.body

    end

    ActionCable.server.broadcast 'room', {
      entries: statistics[:entries],
      terms: statistics[:terms],
      wordcount_max_min: statistics[:wordcount_max_min],
      biggest_title: statistics[:biggest_title],
      lowest_levenshtein: statistics[:lowest_levenshtein],
      lowest_levenshtein_term: statistics[:lowest_levenshtein_term]

    }
  end
end
