require 'rails_helper'

RSpec.describe 'Visitor' do
  it "can visit the about page" do
    visit about_path

    expect(page).to have_content("This application is designed to pull in youtube information to populate tutorials from Turing School of Software and Design's youtube channel. It's designed for anyone learning how to code, with additional features for current students.")
  end
end
