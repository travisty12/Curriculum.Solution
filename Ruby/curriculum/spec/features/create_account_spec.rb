require 'rails_helper'

describe "account creation" do
  it "gives an error when no email is entered" do
    visit '/signup'
    click_on 'Create account'
    expect(page).to have_content "There was an error signing up. Please try again."
  end

  it "gives an error when passwords do not match" do
    visit '/signup'
    fill_in 'user[email]', :with => ENV['TEST_EMAIL']
    fill_in 'user[password]', :with => ENV['TEST_PASS']
    fill_in 'user[password_confirmation]', :with => 'notamatch'
    click_on 'Create account'
    expect(page).to have_content "There was an error signing up. Please try again."
  end

  it "logins in a user upon successful account creation" do
    visit '/signup'
    fill_in 'user[email]', :with => ENV['TEST_EMAIL']
    fill_in 'user[password]', :with => ENV['TEST_PASS']
    fill_in 'user[password_confirmation]', :with => ENV['TEST_PASS']
    click_on 'Create account'
    
    expect(page).to have_content "Signup successful!"
    expect(page).to have_content ENV['TEST_EMAIL']
  end
end