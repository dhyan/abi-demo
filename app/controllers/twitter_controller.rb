class TwitterController < ApplicationController
  before_filter :authenticate_user!

  def index
    unless TwitterOauthSetting.find_by_user_id(current_user.id).nil?
      redirect_to "/twitter_profile"
    end
  end

  def generate_twitter_oauth_url
    # oauth_callback = "http://#{request.host}:#{request.port}/oauth_account"
    #
    # @consumer = OAuth::Consumer.new("PTLCU3Oxz61AeD1nZh7qGSXPj", "XYZkMErRJ1X85TXABNnsmKxTnjTGa1uBAFLhbRbXpOrwaA9acP", :site => "https://api.twitter.com")
    #
    # @request_token = @consumer.get_request_token(:oauth_callback => oauth_callback)
    # session[:request_token] = @request_token

    #redirect_to @request_token.authorize_url(:oauth_callback => oauth_callback)
     redirect_to twitter_profile_url
  end


  # def oauth_account
  #   if TwitterOauthSetting.find_by_user_id(current_user.id).nil?
  #     @request_token = session[:request_token]
  #     @access_token = @request_token.get_access_token(:oauth_verifier => params["oauth_verifier"])
  #     TwitterOauthSetting.create(:atoken => @access_token.token, :asecret => @access_token.secret, :user_id => current_user.id)
  #     #update_user_account()
  #   end
  #   redirect_to "/twitter_profile"
  # end

  def twitter_profile
    # @user_timeline = get_client.user_timeline
    # @home_timeline = get_client.home_timeline
    @twitter = get_client.search("from:#{current_user.name}", result_type: "recent").take(10)
  end

  private

  def get_client
    # Twitter.configure do |config|
    #   config.consumer_key = "rfoURDvnXa4eKoypFRmJVA"
    #   config.consumer_secret = "u6Vm5CDHmiOfT7UmJRS7tRJeITQrKXKs7M97in46PGo"
    # end
    #
    # Twitter::Client.new(
    #     :oauth_token => TwitterOauthSetting.find_by_user_id(current_user.id).atoken,
    #     :oauth_token_secret => TwitterOauthSetting.find_by_user_id(current_user.id).asecret
    # )

    # Twitter::REST::Client.new do |config|
    #   config.consumer_key        = "rfoURDvnXa4eKoypFRmJVA"
    #   config.consumer_secret     = "u6Vm5CDHmiOfT7UmJRS7tRJeITQrKXKs7M97in46PGo"
    #   config.access_token        = TwitterOauthSetting.find_by_user_id(current_user.id).atoken,
    #   config.access_token_secret = TwitterOauthSetting.find_by_user_id(current_user.id).asecret
    # end

   Twitter::REST::Client.new do |config|
      config.consumer_key        = "PTLCU3Oxz61AeD1nZh7qGSXPj"
      config.consumer_secret     = "XYZkMErRJ1X85TXABNnsmKxTnjTGa1uBAFLhbRbXpOrwaA9acP"
      config.access_token        = "2512972026-Fxvvt6jo7d77a2igrJahNjxWGFqoU3H9vYbBi4A"
      config.access_token_secret = "qkufa46zu8GIfdklrc2GmGVlo9237qWJbIXsV90Zv3vFD"
    end
  end

  # def update_user_account
  #   user_twitter_profile = get_client.user
  #   current_user.update_attributes({
  #       :name => user_twitter_profile.name,
  #       :screen_name => user_twitter_profile.screen_name,
  #       :url => user_twitter_profile.url,
  #       :profile_image_url => user_twitter_profile.profile_image_url,
  #       :location => user_twitter_profile.location,
  #       :description => user_twitter_profile.description
  #   })
  #
  # end

end
