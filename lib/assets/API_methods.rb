module APIMethods
    require 'uri'
    require 'net/http'
    require 'json'
  
    def search(search_term, sroffset = 10, retrieved_articles = [])
      puts "Searching for #{search_term}" unless retrieved_articles.length > 0


      uri = URI("https://en.wikipedia.org/w/api.php?action=query&list=search&srsearch=#{search_term}&format=json&sroffset=#{sroffset}")
      response = Net::HTTP.get_response(uri)
      json_response = JSON.parse(response.body)

      json_response['query']['search'].each do |item|

        individual_uri = URI("https://en.wikipedia.org/w/api.php?action=query&prop=info&pageids=#{item['pageid']}&inprop=url&format=json")
        individual_response = Net::HTTP.get_response(individual_uri)
        extra_info = JSON.parse(individual_response.body)

        fullurl = extra_info['query']['pages'][item['pageid'].to_s]['fullurl']

        if search_complete?(retrieved_articles)
          return retrieved_articles
        else
          puts retrieved_articles.length
                unless retrieved_articles.empty?

                      unless WikiEntry.show_ids.include?(item['pageid'])
      #in case the articles undergo changes during the search, or any other duplication incident
                        retrieved_articles.push(WikiEntry.new(item['title'],item['pageid'].to_i, item['wordcount'], item['snippet'], fullurl))

                      end
                else
                retrieved_articles.push(WikiEntry.new(item['title'],item['pageid'].to_i, item['wordcount'], item['snippet'], fullurl))
                end

                if retrieved_articles.length < 40
                  search(search_term, sroffset+10, retrieved_articles)
                else
                  search(search_term, sroffset+(50-retrieved_articles.length), retrieved_articles)
                end
          end
      end
    end

    def search_complete?(articles)
      if articles.length >= 50
        true
      else
        false
      end
    end

    def wordcount?
      puts 'Would you like the entries sorted by wordcount?(y/n)'
      sort_factor = gets.chomp.downcase
        unless ['y','n'].include?(sort_factor)
          puts 'Please provide valid input in the form of "y" or "n"'
          wordcount_or_title?()
        else
          if sort_factor == 'y'
            return true
          else
            return false
          end
        end
    end

    def descending?
      puts 'Descending?(y/n)'
      descending = gets.chomp.downcase
      if descending == 'y'
        true
      else
        false
      end
    end

    def sort(articles, by_wordcount, descending)
      if by_wordcount
        articles = articles.sort_by { |article| article.wordcount}
      else
        articles = articles.sort_by { |article| article.title}
      end

        articles = articles.reverse if descending
          return articles
    end

    def levenshtein_distance(s, t)
      m = s.length
      n = t.length
      return m if n == 0
      return n if m == 0
      d = Array.new(m+1) {Array.new(n+1)}

      (0..m).each {|i| d[i][0] = i}
      (0..n).each {|j| d[0][j] = j}
      (1..n).each do |j|
        (1..m).each do |i|
          d[i][j] = if s[i-1] == t[j-1]
                      d[i-1][j-1]
                    else
                      [ d[i-1][j]+1,
                        d[i][j-1]+1,
                        d[i-1][j-1]+1,
                      ].min
                    end
        end
      end
      d[m][n]
    end

#    articles = search(search_term)
#    sorted_articles = sort(articles,wordcount?(), descending?())

    
end