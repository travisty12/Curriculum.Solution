class Lesson < ApplicationRecord
  scope :search, -> (name) { where("lower(title) like ? OR lower(content) like ?", "%#{name.downcase}%", "%#{name.downcase}%") }
  scope :sort_by_method, -> (method) { order("#{method[0]} #{method[1]}") }
  
  has_many :lesson_tracks
  has_many :tracks, :through => :lesson_tracks

  validates :title, presence: true
  validates :content, presence: true

  validates_length_of :title, minimum: 5, maximum: 50
  validates_length_of :content, minimum: 50

  before_save(:titleize_lesson)

  private
    def titleize_lesson
      self.title = self.title.titleize
    end
end