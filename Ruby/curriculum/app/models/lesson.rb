class Lesson < ApplicationRecord
  has_many :lesson_tracks
  has_many :tracks, :through => :lesson_tracks
end