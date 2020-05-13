require 'rails_helper'

RSpec.describe "User" do
  it "can view bookmarks" do
    tutorial1 = create(:tutorial, title: "How to Tie Your Shoes")
    video1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial1, position: 0)
    video2 = create(:video, title: "The Ask-Your-Teacher Technique", tutorial: tutorial1, position: 1)
    tutorial2 = create(:tutorial, title: "How to Spell Avocado")
    video3 = create(:video, title: "Ava co do", tutorial: tutorial2, position: 0)
    video4 = create(:video, title: "Obagoddo", tutorial: tutorial2, position: 1)
    video5 = create(:video, title: "Aggogo", tutorial: tutorial2, position: 2)

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    create(:user_video, user: user, video: video5)
    create(:user_video, user: user, video: video2)
    create(:user_video, user: user, video: video3)
    create(:user_video, user: user, video: video1)

    visit dashboard_path

    within('#bookmarks') do
      expect(page.all('h1')). to have_content("Bookmarked Segments")
      within("#tutorial-#{tutorial1.id}") do
        expect(page.all('h3')).to have_content(tutorial1.title)
        expect(page.all('li')[0]).to have_link(video1.title)
        expect(page.all('li')[1]).to have_link(video2.title)
      end
      within("#tutorial-#{tutorial2.id}") do
        expect(page.all('h3')).to have_content(tutorial2.title)
        expect(page.all('li')[0]).to have_link(video3.title)
        expect(page.all('li')[1]).to have_link(video5.title)
        expect(page).to have_no_link(video4.title)
      end
    end
  end
end