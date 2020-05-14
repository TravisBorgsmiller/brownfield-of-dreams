require 'rails_helper'

RSpec.describe 'Visitor' do
  it "can visit the about page" do
    visit get_started_path

    expect(page).to have_content("Get Started")
  end
end
