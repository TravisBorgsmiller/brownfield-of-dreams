require 'rails_helper'

RSpec.describe 'Non-admin' do
  it 'cannot enter the admin namespace' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit admin_dashboard_path
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end

