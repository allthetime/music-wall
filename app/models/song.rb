class Song < ActiveRecord::Base
  validates_presence_of :author, :title
  validates_format_of :url, 
                      :with => /(^https?:\/\/|^$)/, 
                      :on => :create, 
                      :multiline => true

  belongs_to :user         
  has_many :votes             
end