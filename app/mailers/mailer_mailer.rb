class MailerMailer < ApplicationMailer

default from: "touma199@gmail.com"

  def send_mail(mail_title,mail_content,group_users)
    @mail_title = mail_title
    @mail_content = mail_content
  end

end
