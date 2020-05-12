require 'rails_helper'

describe 'User' do
  before(:each) do
    @alex = create(:user, gh_token: ENV['GITHUB_TOKEN1'], gh_uid: ENV['GITHUB_UID1'])
    @travis = create(:user, gh_token: ENV['GITHUB_TOKEN2'], gh_uid: ENV['GITHUB_UID2'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@alex)
  end

  it 'is given a link to become friends with another user if they both have accounts and are not already friends' do
    VCR.use_cassette('can_form_friendships') do
      visit dashboard_path
      within('#github-followers') do
        within('#follower-TravisBorgsmiller') do
          expect(page).to have_button('Add as Friend')
        end
        within('#follower-tayjames') do
          expect(page).to have_no_button('Add as Friend')
        end
      end

      within('#github-following') do
        within('#following-TravisBorgsmiller') do
          expect(page).to have_button('Add as Friend')
        end
        within('#following-tayjames') do
          expect(page).to have_no_button('Add as Friend')
        end
      end
    end
  end

  it 'can click a link to add a friend' do
    VCR.use_cassette('can_add_a_link') do
      visit dashboard_path
      expect(@alex.friends).to eq([])

      within('#following-TravisBorgsmiller') do
        click_button('Add as Friend')
      end

      @alex.reload
      visit dashboard_path

      within('#following-TravisBorgsmiller') do
        expect(page).to have_no_button("Add as Friend")
      end

      expect(@alex.friends).to eq([@travis])
    end
  end

  xit 'cannot send request to add friend if there is no matching gh_uid in system' do
    visit dashboard_path
    visit friendships_path(gh_uid: 12345) #how to post in capybara?

    expect(page).to have_content("Unable to find registered user with that GitHub UID")
  end
end


# request test for capybara post method
# labeled request type test
# folder in specs/requests