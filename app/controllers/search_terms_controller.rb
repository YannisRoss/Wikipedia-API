# frozen_string_literal: true

class SearchTermsController < ApplicationController
  require './lib/assets/API_methods'
  include APIMethods

  def index
    @search_terms = SearchTerm.all
    @search_terms_with_entries = []
    @search_terms.each do |term|
      @search_terms_with_entries.push({
                                        id: term.id,
                                        creator: term.user,
                                        body: term.body,
                                        entries: term.wiki_entries
                                      })
    end
  end

  def show
    @search_term = SearchTerm.find(params[:id])
    @search_term_with_entries = []
    @search_term_with_entries.push({
                                     id: @search_term.id,
                                     creator: @search_term.user,
                                     body: @search_term.body,
                                     entries: @search_term.wiki_entries
                                   })
  end

  def destroy
    @search_term = SearchTerm.find(params[:id])
    if @search_term.destroy
      redirect_to root_path, notice: 'search_term was successfully destroyed.'
    else
      redirect_to root_path, alert: "search_term destroy failed, #{search_term.errors.full_messages.first}"
    end
  end

  def create
    @wiki_entries = WikiEntry.all
    @search_term = SearchTerm.new(search_term_params)

    if SearchTerm.any? { |term| term.body == @search_term.body }
      search(SearchTerm.where(body: @search_term.body)[0])
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'search complete.' }
      end
      return
    end
    respond_to do |format|
      if @search_term.save
        search(@search_term)
        format.html { redirect_to root_path, notice: 'search_term was successfully created.' }
        format.json { render :show, status: :created, location: @search_term }
        StatisticsBroadcasterJob.perform_now
      #   ActionCable.server.broadcast 'room', {
      #         entries: @wiki_entries,
      #         terms: SearchTerm.all,
      #         wordcount_max_min: [@wiki_entries.order(:wordcount).limit(1).first.title, @wiki_entries.order(wordcount: :desc).limit(1).first.title],
      #         biggest_title: @wiki_entries.sort_by{|entry| entry.title}.first.title,
      #         lowest_levenshtein: @wiki_entries.sort_by{|entry| entry.levenshtein_distance(entry.title, entry.search_term.body)}.first.title,
      #         lowest_levenshtein_term: @wiki_entries.sort_by{|entry| entry.levenshtein_distance(entry.title, entry.search_term.body)}.first.search_term.body,

      #     }

      else
        format.html do
          redirect_to root_path, alert: "search_term failed, #{@search_term.errors.full_messages.first}",
                                 status: :unprocessable_entity
        end
        format.json { render json: @search_term.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def search_term_params
    params.require(:search_term).permit(:body, :user_id)
  end
end
