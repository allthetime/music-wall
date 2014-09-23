class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :track

  validates_uniqueness_of :user_id, :scope => "song_id"

end