require 'rails_helper'

describe 'User' do
  before(:each) do
    user1 = create(:user, gh_token: ENV['GITHUB_TOKEN1'], gh_uid: ENV['GITHUB_UID1'])
    user2 = create(:user, gh_token: ENV['GITHUB_TOKEN2'], gh_uid: ENV['GITHUB_UID2'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit dashboard_path
  end
  it 'is given a link to become friends with a user if they both have accounts' do

    within('#github-followers') do
      expect(page).to have_content('javier-aguilar | Add as Friend')
      expect(page).to have_no_content('tayjames | Add as Friend')

    end

    within('#github-following') do
      expect(page).to have_content('javier-aguilar | Add as Friend')
      expect(page).to have_no_content('tayjames | Add as Friend')
    end
  end

  it 'can click link to add a friend' do

  end
end
