require 'rails_helper'
RSpec.describe "An Admin" do
  it "can import a youtube playlist" do
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
      expect(page.all('li')[0]).to have_content('Final Fantasy VII Remake (dunkview)')
      expect(page.all('li')[1]).to have_content('Animal Crossing : New Horizons (dunkview)')
      expect(page.all('li')[2]).to have_content('Shenmue 3')
      expect(page.all('li')[3]).to have_content('COVID-19 Safety Video')
      expect(page.all('li')[4]).to have_content('Dreams')
      expect(page.all('li')[5]).to have_content('Videogame Structure Evolution')
    end
  end
end
#
# As an admin
# When I visit '/admin/tutorials/new'
# Then I should see a link for 'Import YouTube Playlist'
# When I click 'Import YouTube Playlist'
# Then I should see a form
#
# And when I fill in 'Playlist ID' with a valid ID
# Then I should be on '/admin/dashboard'
# And I should see a flash message that says 'Successfully created tutorial. View it here.'
# And 'View it here' should be a link to '/tutorials/:id'
# And when I click on 'View it here'
# Then I should be on '/tutorials/:id'
# And I should see all videos from the YouTube playlist
# And the order should be the same as it was on YouTube
