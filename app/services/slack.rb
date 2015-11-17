class Slack
  def initialize token=nil
    @token ||= ENV.fetch("marvin_bot_token")
  end

  def call endpoint
    HTTParty.post "https://slack.com/api/#{endpoint}",
      query: { token: @token }
  end
end
