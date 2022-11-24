class UserMailer < ApplicationMailer

  def welcome
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
