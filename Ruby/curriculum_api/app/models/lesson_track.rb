class LessonTrack < ApplicationRecord
  belongs_to :lesson
  belongs_to :track 
end