class Track < ApplicationRecord
  scope :search, -> (name) { where("lower(name) like ?", "%#{name.downcase}%") }
  scope :sort_by_method, -> (method) { order("#{method[0]} #{method[1]}") }
  has_many :lesson_tracks
  has_many :lessons, :through => :lesson_tracks

  validates :name, presence: true
  validates_length_of :name, maximum: 50
  before_save(:titleize_track)

  private
    def titleize_track
      self.name = self.name.titleize
    end
end