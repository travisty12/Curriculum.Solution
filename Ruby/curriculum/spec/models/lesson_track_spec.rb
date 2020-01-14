require 'rails_helper'

describe LessonTrack do
  it { should belong_to(:lesson) }
  it { should belong_to(:track) }
end