require 'rails_helper'

describe 'A registered user' do
  it 'can view their own GitHub following list' do
    VCR.use_cassette('gh_following') do
      user = create(:user)
      user.gh_token = ENV['GITHUB_TOKEN1']

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

        within('#github') do
          expect(page).to have_content('GitHub')
        within('#github-following') do
          expect(page).to have_content('Following')
          expect(page).to have_link('javier-aguilar', href: 'https://github.com/javier-aguilar')
          expect(page).to have_link('brian-greeson', href: 'https://github.com/brian-greeson')
          expect(page).to have_link('PaulDebevec', href: 'https://github.com/PaulDebevec')
          expect(page).to have_link('foleymichelle9', href: 'https://github.com/foleymichelle9')
          expect(page).to have_link('tylertomlinson', href: 'https://github.com/tylertomlinson')
        end
      end
    end
  end

  it 'cannot see a GitHub following section if they have no GitHub token' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_no_selector('#github-following')
  end

  it 'cannot see other registered users GitHub following' do
    VCR.use_cassette('no_gh_following') do
      user1 = create(:user)
      user1.gh_token = ENV['GITHUB_TOKEN1']
      user2 = create(:user)
      user2.gh_token = ENV['GITHUB_TOKEN2']

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

      visit dashboard_path

      within('#github-following') do
        expect(page).to have_content('Following')
        expect(page).to have_no_link('javier-aguilar', href: 'https://github.com/javier-aguilar')
        expect(page).to have_no_link('brian-greeson', href: 'https://github.com/brian-greeson')
        expect(page).to have_no_link('PaulDebevec', href: 'https://github.com/PaulDebevec')
        expect(page).to have_no_link('foleymichelle9', href: 'https://github.com/foleymichelle9')
        expect(page).to have_no_link('tylertomlinson', href: 'https://github.com/tylertomlinson')
      end
    end
  end
end
