require 'rails_helper'

describe "As a logged in user" do
  describe "who does not have a github token" do
    before do
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
    end

    scenario "after I go through the oauth process I have a token and can see all my github info" do
      user = create(:user, github_token: nil)

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

      expect(page).to have_content("Github Repos")
      expect(page).to have_content("Github Followers")
      expect(page).to have_content("Following on Github")

      expect(current_path).to eq("/dashboard")

      user = User.first

      expect(user.github_token.nil?).to eq(false)
      expect(user.uid).to eq(51250305)
    end
  end
end







# As a user
# When I visit /dashboard
# Then I should see a link that is styled like a button that says "Connect to Github"
# And when I click on "Connect to Github"
# Then I should go through the OAuth process
# And I should be redirected to /dashboard
# And I should see all of the content from the previous Github stories (repos, followers, and following)
