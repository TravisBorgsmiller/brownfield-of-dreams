require "rails_helper"

RSpec.describe RegistrationMailer, type: :mailer do
  describe "activate" do
    it "renders the headers" do
      user = create(:user)
      registration = RegistrationMailer.activate(user)
      
      expect(registration.subject).to eq("Please activate your account")
      expect(registration.to).to eq([user.email])
      expect(registration.from).to eq(["noreply@shielded-falls-56694.herokuapp.com"])
    end

    it "renders the body" do
      user = create(:user)
      registration = RegistrationMailer.activate(user)

      expect(registration.body.encoded).to match("Please activate your account")
    end
  end
end
