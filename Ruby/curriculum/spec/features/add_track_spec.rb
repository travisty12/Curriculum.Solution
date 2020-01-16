require 'rails_helper'

describe "track creation" do
  it "blocks unauthorized Create/Update/Destroy attempts" do
    visit new_track_path
    fill_in 'track[name]', :with => 'Intro'
    click_on 'Create Track'
    expect(page).to have_content 'Unauthorized.'
  end
  
  it "allows Create/Update/Destroy after signup/signin" do
    visit '/signup'
    fill_in 'user[email]', :with => ENV['TEST_EMAIL']
    fill_in 'user[password]', :with => ENV['TEST_PASS']
    fill_in 'user[password_confirmation]', :with => ENV['TEST_PASS']
    click_on 'Create account'

    visit tracks_path
    click_link 'Create new track'
    fill_in 'track[name]', :with => 'Intro'
    click_on 'Create Track'
    expect(page).to have_content 'Track added safely!'
    expect(page).to have_content 'Intro'
  end
  
  it "gives an error when no name is entered" do
    visit '/signup'
    fill_in 'user[email]', :with => ENV['TEST_EMAIL']
    fill_in 'user[password]', :with => ENV['TEST_PASS']
    fill_in 'user[password_confirmation]', :with => ENV['TEST_PASS']
    click_on 'Create account'
    
    visit new_track_path
    click_on 'Create Track'
    expect(page).to have_content "Name can't be blank"
  end

end