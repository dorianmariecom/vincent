class VincentMailerPreview < ActionMailer::Preview
  def reddit_email
    VincentMailer.with(urls: Reddit.fetch).reddit_email
  end
end
