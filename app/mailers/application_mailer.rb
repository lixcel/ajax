class ApplicationMailer < ActionMailer::Base
  default from: '管理人です。<from@example.com>'
  layout 'mailer'
end
