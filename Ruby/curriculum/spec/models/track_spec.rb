require 'rails_helper'

describe Track do
  it { should have_many(:lessons).through(:lesson_tracks)}
  it { should validate_presence_of :name }
  it { should validate_length_of(:name).is_at_most(50)}
end