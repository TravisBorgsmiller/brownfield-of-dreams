require 'rails_helper'

RSpec.describe "User" do
  before(:each) do
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:github, {credentials: {token: 'test_token'}})
  end

  it "can connect to GitHub" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path
    click_button("Connect to GitHub")
    expect(current_path).to eq(dashboard_path)

    within('#github') do
      expect(page).to have_css('#github-repos')
      expect(page).to have_css('#github-followers')
      expect(page).to have_css('#github-following')
    end
  end
end