require 'rails_helper'
require 'spec_helper'
require 'monkey_patch'

describe Movie do
    it 'Should find movies with the same direc,tors' do
        movie1 = Movie.create(title: 'Tx1', director: 'Dx1')
        movie2 = Movie.create(title: 'Tx2', director: 'Dx1')
        movie3 = Movie.create(title: 'Tx3', director: 'Dx2')
        results = Movie.same_movies(movie1.title)
        expect(results).to eq([movie1, movie2])
    end
    
    it 'Should return nil when no director info ' do
        movie1 = Movie.create(title: 'Tx4')
        results = Movie.same_movies(movie1.title)
        expect(results).to eq(nil)
    end
end