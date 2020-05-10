require 'rails_helper'

RSpec.describe "User" do
  before(:each) do
    OmniAuth.config.mock_auth[:twitter] = nil
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
  end

  it "can connect to GitHub" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    OmniAuth.config.test_mode = true

    visit dashboard_path
    click_button("Connect to GitHub")

    #OAuth process here
    OmniAuth.config.add_mock(:github, {:uid => 'alex-latham'})

    expect(current_path).to eq(dashboard_path)

    within('#github') do
      expect(page).to have_css('#github-repos')
      expect(page).to have_css('#github-followers')
      expect(page).to have_css('#github-following')
    end
  end
end