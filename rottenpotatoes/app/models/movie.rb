class Movie < ActiveRecord::Base
  
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.same_movies movie_title
    #director_name = Movie.find_by_title(movie_title).director
    director_name = Movie.find_by(title: movie_title).director
    if director_name.nil? or director_name.blank?
      return nil
    else
      return Movie.where(director: director_name)
    end 
  end
  
  def self.show_para para
    puts para
  end 
end
