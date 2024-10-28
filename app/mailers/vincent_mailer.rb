class VincentMailer < ApplicationMailer
  def reddit_email
    @urls = params.fetch(:urls)
    mail(
      from: "dorian@dorianmarie.com",
      to: "dorian@dorianmarie.com",
      subject: "reddit"
    )
  end
end
