require 'rails_helper'

describe 'visitor visits video show page' do
  it 'hovers over a disabled bookmark button and sees a tooltip advising to log in' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)

    within('.bookmarks-btn') do
      expect(page).to have_button('Bookmark', disabled: true, title: "You must be logged in to bookmark videos")
    end
  end
end
