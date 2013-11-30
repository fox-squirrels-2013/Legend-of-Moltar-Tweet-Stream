get '/' do
  @tweet_count = TweetCount.last
  unless @tweet_count
    @tweet_count = TweetCount.create
  end

  client = Twitter::Streaming::Client.new do |config|
    config.consumer_key        = ENV["CONSUMER_KEY"]
    config.consumer_secret     = ENV["CONSUMER_SECRET"]
    config.access_token        = ENV["ACCESS_TOKEN"]
    config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
  end

  topics = []
  attr_values = {}

  @tweet_count.attributes.keys.each do |attr_name|
    topics << attr_name unless attr_name == 'id'
    attr_values[attr_name] = @tweet_count[attr_name]
  end

  client.filter(:track => topics.join(",")) do |tweet|
    text = tweet.text
    topics.each do |topic|
      if text.match(topic)
        attr_values[topic] += 1
        @tweet_count.update_attribute(topic, attr_values[topic])
      end
    end
  end
end