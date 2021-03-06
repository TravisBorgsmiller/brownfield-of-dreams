require 'rails_helper'

feature 'A registered user' do
  scenario 'can view their own GitHub repos' do
    VCR.use_cassette('github_repos') do
      user = create(:user)
      user.gh_token = ENV['GITHUB_TOKEN1']

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      within('#github') do
        expect(page).to have_content('GitHub')
        within('#github-repos') do
          expect(page).to have_content('Repos')
          expect(page).to have_link('brownfield-of-dreams', href: 'https://github.com/TravisBorgsmiller/brownfield-of-dreams')
          expect(page).to have_link('monster_shop_final', href: 'https://github.com/alex-latham/monster_shop_final')
          expect(page).to have_link('here-be-dragons', href: 'https://github.com/alex-latham/here-be-dragons')
          expect(page).to have_link('neos', href: 'https://github.com/alex-latham/neos')
          expect(page).to have_link('enigma', href: 'https://github.com/alex-latham/enigma')
        end
      end
    end
  end

    scenario 'cannot see a GitHub repos section if they have no GitHub token' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to have_selector('#github')
      expect(page).to have_no_selector('#github-repos')
    end

    scenario 'cannot see other registered users GitHub repos' do
      VCR.use_cassette('github_repos_2') do
        user1 = create(:user)
        user1.gh_token = ENV['GITHUB_TOKEN1']
        user2 = create(:user)
        user2.gh_token = ENV['GITHUB_TOKEN2']

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

        visit dashboard_path

        within('#github') do
        expect(page).to have_content('GitHub')
        within('#github-repos') do
          expect(page).to have_content('Repos')
          expect(page).to have_no_link('monster_shop_final', href: 'https://github.com/alex-latham/monster_shop_final')
          expect(page).to have_no_link('here-be-dragons', href: 'https://github.com/alex-latham/here-be-dragons')
          expect(page).to have_no_link('neos', href: 'https://github.com/alex-latham/neos')
          expect(page).to have_no_link('road_trip', href: 'https://github.com/alex-latham/road_trip')
        end
      end
    end
  end
end
