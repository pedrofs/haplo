class NotificationMailer < ActionMailer::Base
  default from: 'haplo@haplo.io'

  def invite_message(user, host, port)
    @user = user
    @host = host
    @port = port
    mail(to: @user.email, subject: 'Você foi convidado para o haplo.io')
  end
end