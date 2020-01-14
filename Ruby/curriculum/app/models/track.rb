class Track < ApplicationRecord
  has_many :lesson_tracks
  has_many :lessons, :through => :lesson_tracks
end