require 'rails_helper'

describe Track do
  it { should have_many(:lessons).through(:lesson_tracks)}
end