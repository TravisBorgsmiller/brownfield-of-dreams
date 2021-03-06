require 'rails_helper'

RSpec.describe "As a logged in user" do
  describe "I can send an email to invite someone" do
    describe "by entering their github username on my dashboard" do
      scenario "if they have an email in github" do
        VCR.use_cassette('invite_valid_w_email') do
          user = create(:user, gh_token: ENV["GITHUB_TOKEN2"])

          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

          visit dashboard_path

          click_button 'Send an Invite'

          expect(current_path).to eq(new_invitation_path)

          fill_in :handle, with: 'TravisBorgsmiller'

          expect do
            click_button 'Send Invite'
          end.
          to change { ActionMailer::Base.deliveries.count }.by(1)

          expect(current_path).to eq(dashboard_path)

          expect(page).to have_content('Successfully sent invite!')
        end
      end

      scenario "Fails gracefully if no github email present" do
        VCR.use_cassette('invite_valid_wo_email') do

          user = create(:user, gh_token: ENV["GITHUB_TOKEN2"])

          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

          visit dashboard_path

          click_button 'Send an Invite'

          expect(current_path).to eq(new_invitation_path)

          fill_in :handle, with: 'alex-latham'

          click_button 'Send Invite'

          expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
          expect(page).to have_button 'Send Invite'
        end
      end

      scenario "I am alerted if I enter an invalid github handle" do
        VCR.use_cassette('invite_invalid_gh') do

          user = create(:user, gh_token: ENV["GITHUB_TOKEN2"])

          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

          visit dashboard_path

          click_button 'Send an Invite'

          expect(current_path).to eq(new_invitation_path)

          fill_in :handle, with: 'invalidghuserhandlefr123445'

          click_button 'Send Invite'

          expect(page).to have_content("Could not locate GitHub user with that handle.")
          expect(page).to have_button 'Send Invite'
        end
      end
    end
  end
end
