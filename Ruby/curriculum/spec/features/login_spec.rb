require 'rails_helper'

describe "account login" do
  it "gives an error when no fields are entered" do
    visit '/signin'
    click_on 'Enter'
    expect(page).to have_content "There was an error logging you in. Please try again."
  end

  it "gives an error when an incorrect password is entered" do
    visit '/signin'
    fill_in 'email', :with => ENV['TEST_EMAIL']
    fill_in 'password', :with => 'notamatch'
    click_on 'Enter'
    expect(page).to have_content "There was an error logging you in. Please try again."
  end

  it "allows a user to login with created account, after signup and logout" do
    visit '/signup'
    fill_in 'user[email]', :with => ENV['TEST_EMAIL']
    fill_in 'user[password]', :with => ENV['TEST_PASS']
    fill_in 'user[password_confirmation]', :with => ENV['TEST_PASS']
    click_on 'Create account'
    click_on 'Sign out'

    visit '/signin'
    fill_in 'email', :with => ENV['TEST_EMAIL']
    fill_in 'password', :with => ENV['TEST_PASS']
    click_on 'Enter'
    expect(page).to have_content "Login successful!"
    expect(page).to have_content ENV['TEST_EMAIL']
  end
end