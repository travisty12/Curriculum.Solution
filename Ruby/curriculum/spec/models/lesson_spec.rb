require 'rails_helper'

describe Lesson do
  it { should have_many(:tracks).through(:lesson_tracks)}
end