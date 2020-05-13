require 'rails_helper'

RSpec.describe "User", type: :request do
  it "can activate email with a valid token" do
    user = create(:user, email_token: SecureRandom.urlsafe_base64.to_s)

    expect(user.active).to eq(false)

    get "/users/#{user.email_token}/confirm_email"

    user.reload

    expect(user.active).to eq(true)
    expect(user.email_token).to eq(nil)
  end

  it "cannot activate email with a valid token" do
    email_token1 = SecureRandom.urlsafe_base64.to_s

    user = create(:user, email_token: SecureRandom.urlsafe_base64.to_s)

    expect(user.active).to eq(false)

    get "/users/#{SecureRandom.urlsafe_base64.to_s}/confirm_email"

    user.reload

    expect(user.active).to eq(false)
    expect(user.email_token).to_not eq(nil)
  end
end