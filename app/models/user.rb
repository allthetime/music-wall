class User < ActiveRecord::Base
  validates_presence_of :name, :password
  validates_uniqueness_of :name

  has_many :songs
  has_many :votes
  has_many :reviews

end


