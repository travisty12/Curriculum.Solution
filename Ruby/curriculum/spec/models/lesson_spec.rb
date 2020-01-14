require 'rails_helper'

describe Lesson do
  it { should have_many(:tracks).through(:lesson_tracks)}
  it { should validate_presence_of :title }
  it { should validate_presence_of :content }
  it { should validate_length_of(:title).is_at_most(100)}
  it { should validate_length_of(:title).is_at_least(5)}
  it { should validate_length_of(:content).is_at_least(50)}
end