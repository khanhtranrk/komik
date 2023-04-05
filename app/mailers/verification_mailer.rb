# frozen_string_literal: true

class VerificationMailer < ApplicationMailer
  default from: 'fortisiks.sapce'

  layout 'mailer'
  def verify(email, code)
    @verification = { email:, code: }
    mail(to: @verification[:email], subject: 'Verify')
  end
end
