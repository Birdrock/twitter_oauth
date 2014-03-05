class TweetWorker
  include Sidekiq::Worker

  def perform(tweet_id)
    tweet = Tweet.find(tweet_id)
    user  = tweet.user

    client = Twitter::REST::Client.new do |config|
      config.consumer_key = $client.consumer_key
      config.consumer_secret = $client.consumer_secret
      config.access_token = user.oauth_token
      config.access_token_secret = user.oauth_secret
    end

    # set up Twitter OAuth client here
    # actually make API call
    # Note: this does not have access to controller/view helpers
    # You'll have to re-initialize everything inside here

    client.update(tweet.status)
  end
end
