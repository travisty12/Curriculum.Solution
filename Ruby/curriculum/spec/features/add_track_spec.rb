require 'rails_helper'

describe "track creation" do
  it "adds a new track" do
    visit tracks_path
    click_link 'Create new track'
    fill_in 'Name', :with => 'Intro'
    click_on 'Create Track'
    expect(page).to have_content 'Track added safely!'
    expect(page).to have_content 'Intro'
  end

  it "gives an error when no name is entered" do
    visit new_track_path
    click_on 'Create Track'
    expect(page).to have_content "Name can't be blank"
  end
end