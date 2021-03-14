require 'rails_helper'
require 'spec_helper'
require 'monkey_patch'

describe MoviesController do
  describe 'Search movies with the same director' do
    it 'should call Movie.similar_movies' do
      expect(Movie).to receive(:same_movies).with('Tx')
      get :search, :title => 'Tx'
    end

    it 'should assign similar movies if director exists' do
      tmp_movies = ['Tx', 'T2']
      Movie.stub(:same_movies).with('Tx').and_return(tmp_movies)
      
      expect(Movie).to receive(:same_movies).with('Tx').and_return(tmp_movies)
      get :search, :title => 'Tx'
    end

    it "should redirect to home page if no director info" do
      Movie.stub(:same_movies).with('Tx').and_return(nil)
      get :search, :title => 'Tx'
      expect(response).to redirect_to(root_url)
    end
  end
  
  describe 'Detail page works' do
    it 'should show movie' do
      movie1 = Movie.create(title: 'T1', director: 'D1')
      expect(Movie).to receive(:find).with(movie1.id.to_s).and_return(movie1)
      get :show, :id => movie1.id
      expect(response).to render_template("movies/show")
    end
  end
  
  describe 'Create method works' do
    it 'creates a new movie' do
      expect {post :create, :title => 'T1', :director => 'T2'}.to change { Movie.count }.by(1)
    end
    it 'redirects to the movie index page' do
      post :create, :title => 'T1', :director => 'T2'
      expect(response).to redirect_to(movies_url)
    end
  end
    
  describe 'Update method works' do
    it 'should update movie' do
      movie1 = Movie.create(title: 'T1', director: 'D1')
      movie1.reload()
      expect(Movie).to receive(:find).with(movie1.id.to_s).and_return(movie1)
      expect(movie1).to receive(:update_attributes!).and_return(movie1)
      put :update, :id => movie1.id.to_i, :movie => {:title => 'T1', :director =>'D2'}
      expect(flash[:notice]).to match (/was successfully updated./)
    end
  end
  
  describe 'Delete method works' do
    movie1 = Movie.create(title: 'T1', director: 'D1')
    it 'destroys a movie' do
      expect {delete :destroy, :id => movie1.id }.to change(Movie, :count).by(-1)
    end
    it 'redirects to movies#index after destroy' do
      delete :destroy, :id => movie1.id
      expect(response).to redirect_to(movies_path)
    end
  end
  
  describe 'GET index' do
    it 'should render the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end
 
end

