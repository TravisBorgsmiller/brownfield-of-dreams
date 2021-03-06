require 'rails_helper'
RSpec.describe "An Admin" do
  it "can import a youtube playlist" do
    VCR.use_cassette('import_playlist') do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit new_admin_tutorial_path
      click_link('Import YouTube Playlist')

      expect(page).to have_current_path(new_admin_tutorial_path(import: 'playlist'))

      fill_in "tutorial[playlist_id]", with: 'PLMBTl5yXyrGQ68Ny1mXCAaSwbjpcVwm49'
      click_button('Submit')

      expect(current_path).to eq(admin_dashboard_path)
      expect(page).to have_content('Successfully created tutorial. View it here.')

      click_link('View it here')

      expect(current_path).to eq(tutorial_path(Tutorial.last))

      within('.tutorials') do
        expect(page.all('li').length).to eq(255)
        expect(page.all('li')[0]).to have_content('Spoiler Alert')
        expect(page.all('li')[254]).to have_content('Hatris (dunkview)')
      end
    end
  end
end
