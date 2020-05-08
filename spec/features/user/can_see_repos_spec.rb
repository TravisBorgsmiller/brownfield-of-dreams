require 'rails_helper'

RSpec.describe 'As a user' do
  it 'shows github repos if logged in' do
    user = create(:user)
    user.first_name = ENV['TRAVIS_GITHUB_TOKEN']
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"

  end

end
