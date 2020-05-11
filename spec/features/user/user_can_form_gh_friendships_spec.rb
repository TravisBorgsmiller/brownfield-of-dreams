require 'rails_helper'

describe 'User' do
  it 'can become friends with a user if they both have accounts' do
    user1 = create(:user, gh_token: ENV['GITHUB_TOKEN1'])
    user2 = create(:user, gh_token: ENV['GITHUB_TOKEN2'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit dashboard_path

    within('#follower-javier-aguilar') do
      expect(page).to have_content('javier-aguilar | Add as Friend')
    end

    within('#following-javier-aguilar') do
      expect(page).to have_content('javier-aguilar | Add as Friend')
    end

    within('#follower-tayjames') do
      expect(page).to have_no_content('Add as Friend')
    end

    within('#following-tayjames') do
      expect(page).to have_no_content('Add as Friend')
    end
  end
end
