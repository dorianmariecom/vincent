class Reddit
  SUBREDDITS = [
    "france",
    "rance",
    "FrenchMemes",
    "Dinosaure"
  ]

  EXTENSIONS = [
    ".jpg",
    ".jpeg",
    ".png",
    ".webp"
  ]

  def initialize
  end

  def self.fetch
    new.fetch
  end

  def fetch
    uri = URI.parse("https://www.reddit.com/api/v1/access_token")
    request = Net::HTTP::Post.new(uri)
    request.basic_auth(client_id, client_secret)
    request.set_form_data(
      grant_type: :password,
      password:,
      username:,
    )

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    access_token = JSON.parse(response.body).fetch("access_token")

    SUBREDDITS.map do |subreddit|
      uri = URI.parse("https://oauth.reddit.com/r/#{subreddit}/top?t=day")
      request = Net::HTTP::Get.new(uri)
      request["Authorization"] = "Bearer #{access_token}"
      request["User-Agent"] = "Vincent"

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      posts = JSON.parse(response.body).fetch("data").fetch("children")

      urls = posts.map { |post| post.fetch("data").fetch("url") }

      urls.select { |url| File.extname(url).in?(EXTENSIONS) }
    end.flatten
  end

  def client_id
    Rails.application.credentials.reddit.client_id
  end

  def client_secret
    Rails.application.credentials.reddit.client_secret
  end

  def username
    Rails.application.credentials.reddit.username
  end

  def password
    Rails.application.credentials.reddit.password
  end
end
