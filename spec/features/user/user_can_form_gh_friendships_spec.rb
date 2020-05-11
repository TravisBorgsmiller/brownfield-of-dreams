require 'rails_helper'

describe 'User' do
  it 'can become friends with a user if they both have accounts' do
    alex = create(:user, gh_token: ENV['GITHUB_TOKEN1'], gh_uid: ENV['GITHUB_UID1'])
    javier = create(:user, gh_token: ENV['GITHUB_TOKEN2'], gh_uid: ENV['GITHUB_UID2'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(alex)

    visit dashboard_path

    within('#github-followers') do
      expect(page).to have_content('javier-aguilar | Add as Friend')
      expect(page).to have_no_content('tayjames | Add as Friend')

    end

    within('#github-following') do
      expect(page).to have_content('javier-aguilar | Add as Friend')
      expect(page).to have_no_content('tayjames | Add as Friend')
    end
  end
end
