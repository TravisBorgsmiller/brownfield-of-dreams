require 'rails_helper'

describe 'User' do
  before(:each) do
    @alex = create(:user, gh_token: ENV['GITHUB_TOKEN1'], gh_uid: ENV['GITHUB_UID1'])
    @travis = create(:user, gh_token: ENV['GITHUB_TOKEN2'], gh_uid: ENV['GITHUB_UID2'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@alex)

    visit dashboard_path
  end
  it 'is given a link to become friends with another user if they both have accounts and are not already friends' do
    within('#github-followers') do
      # Uncomment next line once Travis and Alex are real friends
      # expect(page).to have_content('TravisBorgsmiller | Add as Friend')
      expect(page).to have_no_content('tayjames | Add as Friend')
    end

    within('#github-following') do
      expect(page).to have_content('TravisBorgsmiller | Add as Friend')
      expect(page).to have_no_content('tayjames | Add as Friend')
    end
  end

  it 'can click a link to add a friend' do
    expect(@alex.friends).to eq([])

    within('#following-TravisBorgsmiller') do
      click_link('Add as Friend')
    end

    # If I don't have both the following lines, the test fails -- why?
    @alex.reload # page continues to show a link to add a friend unless this is here
    visit dashboard_path # already have a redirect in Friendships#create tho

    within('#following-TravisBorgsmiller') do
      expect(page).to have_no_content("Add as Friend")
    end

    expect(@alex.friends).to eq([@travis])
  end

  xit 'cannot send request to add friend if there is no matching gh_uid in system' do
    visit friendships_path(gh_uid: 12345)

    expect(page).to have_content("Unable to find registered user with that GitHub UID")
  end
end
