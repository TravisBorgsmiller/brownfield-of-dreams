require 'rails_helper'

feature "An admin can delete a tutorial" do
  scenario "and it should no longer exist" do
    admin = create(:admin)
    tutorial_1 = create(:tutorial)
    tutorial_2 = create(:tutorial)
    video_1 = create(:video, tutorial: tutorial_1)
    video_2 = create(:video, tutorial: tutorial_2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    expect(page).to have_css('.admin-tutorial-card', count: 2)

    within(first('.admin-tutorial-card')) do
      click_button 'Delete'
    end

    expect(page).to have_css('.admin-tutorial-card', count: 1)
    expect(Video.find_by(id: video_1.id)).to eq(nil)
  end
end
