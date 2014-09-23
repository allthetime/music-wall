class User < ActiveRecord::Base
  validates_presence_of :name, :password
  validates_uniqueness_of :name

  has_many :songs
end