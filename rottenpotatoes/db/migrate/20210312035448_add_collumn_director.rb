class AddCollumnDirector < ActiveRecord::Migration
  def change
    add_column(:movies, :director, :string)
  end
end
