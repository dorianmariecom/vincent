# frozen_string_literal: true

class VincentMailer < ApplicationMailer
  def reddit_email
    @urls = params.fetch(:urls)
    mail(
      from: "dorian@dorianmarie.com",
      to: Rails.application.credentials.to,
      subject: "reddit"
    )
  end
end
