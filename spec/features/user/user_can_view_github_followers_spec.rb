require 'rails_helper'

describe 'A registered user' do
  it 'can view their own GitHub followers' do
    user = create(:user)
    user.gh_token = ENV['GITHUB_TOKEN1']

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

      within('#github') do
        expect(page).to have_content('GitHub')
      within('#github-followers') do
        expect(page).to have_content('Followers')
        expect(page).to have_link('javier-aguilar', href: 'https://github.com/javier-aguilar')
        expect(page).to have_link('Ashkanthegreat', href: 'https://github.com/Ashkanthegreat')
        expect(page).to have_link('coloniusrex', href: 'https://github.com/coloniusrex')
        expect(page).to have_link('foleymichelle9', href: 'https://github.com/foleymichelle9')
        expect(page).to have_link('chrisstankus99', href: 'https://github.com/chrisstankus99')
      end
    end
  end

  it 'cannot see a GitHub followers section if they have no GitHub token' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_no_selector('#github-followers')
  end

  it 'cannot see other registered users GitHub followers' do
    user1 = create(:user)
    user1.gh_token = ENV['GITHUB_TOKEN1']
    user2 = create(:user)
    user2.gh_token = ENV['GITHUB_TOKEN2']

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

    visit dashboard_path

    within('#github-followers') do
      expect(page).to have_content('Followers')
      expect(page).to have_no_link('javier-aguilar', href: 'https://github.com/javier-aguilar')
      expect(page).to have_no_link('Ashkanthegreat', href: 'https://github.com/Ashkanthegreat')
      expect(page).to have_no_link('coloniusrex', href: 'https://github.com/coloniusrex')
      expect(page).to have_no_link('foleymichelle9', href: 'https://github.com/foleymichelle9')
      expect(page).to have_no_link('chrisstankus99', href: 'https://github.com/chrisstankus99')
    end
  end
end
