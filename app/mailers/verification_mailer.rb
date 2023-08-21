# frozen_string_literal: true

class VerificationMailer < ApplicationMailer
  default from: "Komik <#{ENV['EMAIL_USERNAME']}>"

  layout 'mailer'
  def verify(email, code)
    @verification = { email:, code: }
    mail(to: @verification[:email], subject: 'Xác nhận tài khoản Komik')
  end
end
