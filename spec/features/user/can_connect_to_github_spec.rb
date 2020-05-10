require 'rails_helper'

describe "As a logged in user" do
  describe "who does not have a github token" do
    before do
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
    end

    scenario "after I go through the oauth process I have a token and can see all my github info" do
      user = create(:user, gh_token: nil)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      stub_omniauth

      visit '/dashboard'

      expect(page).to have_button('Connect to Github')

      expect(page).to_not have_css("#github-repos")
      expect(page).to_not have_css("#github-followers")
      expect(page).to_not have_css("#github-following")

      expect(page).to_not have_content("Github Repos")
      expect(page).to_not have_content("Github Followers")
      expect(page).to_not have_content("Following on Github")

      click_button 'Connect to Github'

      expect(page).to have_css("#github-repos")
      expect(page).to have_css("#github-followers")
      expect(page).to have_css("#github-following")

      expect(page).to have_content("Repos")
      expect(page).to have_content("Followers")
      expect(page).to have_content("Following")

      expect(current_path).to eq("/dashboard")

      user = User.first

      expect(user.gh_token.nil?).to eq(false)
    end
  end
end