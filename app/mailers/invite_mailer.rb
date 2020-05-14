class InviteMailer < ApplicationMailer
  def invite_friend(email, name, sender_name)
    @sender_name = sender_name
    @friend_name = name
    mail(to: email, subject: 'Join Brownfield of Dreams!')
  end
end
