class InvitationMailer < ApplicationMailer
  def invite_friend(user, friend)
    @sender_name = user.first_name
    @friend_name = friend[:name]
    mail(to: friend[:email], subject: 'Join Brownfield of Dreams!')
  end
end
