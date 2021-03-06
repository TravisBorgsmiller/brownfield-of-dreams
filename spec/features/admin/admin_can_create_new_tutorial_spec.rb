require 'rails_helper'

describe "As an admin" do
    scenario "can add a tutorial" do
        admin = create(:user, role: :admin)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        visit "/admin/dashboard"

        click_link "New Tutorial"

        fill_in :tutorial_title, with: "Shredding gnar"
        fill_in :tutorial_description, with: "Skiing down the slopes on a big pow day"
        fill_in :tutorial_thumbnail, with: "https://pbs.twimg.com/profile_images/669238564543041536/F8oJKPUG_400x400.jpg"
        fill_in "videos[video_id]", with: "dGGegRjExsk"

        click_button "Save"

        tutorial = Tutorial.last

        expect(current_path).to eq(tutorial_path(tutorial.id))
        expect(page).to have_content("Successfully created tutorial.")
        expect(tutorial.videos.length).to eq(1)
    end

    scenario "will not add tutorial when invalid information is given" do
        admin = create(:user, role: :admin)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        visit new_admin_tutorial_path

        fill_in :tutorial_title, with: " "
        fill_in :tutorial_description, with: "Skiing down the slopes on a big pow day"
        fill_in :tutorial_thumbnail, with: "https://drncvpyikhjv3.cloudfront.net/sites/56/2015/09/16182352/ski-featured.png"
        fill_in "videos[video_id]", with: "dGGegRjExsk"

        click_button "Save"

        expect(page).to have_content("Title can't be blank")
    end
  end
