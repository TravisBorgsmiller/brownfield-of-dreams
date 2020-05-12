require 'rails_helper'

RSpec.describe "User", type: :request do
  it "cannot form friendship using invalid gh uid parameter in post request" do
    post '/friendships', params: {gh_uid: 12345}

    expect(response).to redirect_to(dashboard_path)
    expect(flash[:error]).to eq('Unable to find registered user with that GitHub UID')
  end
end