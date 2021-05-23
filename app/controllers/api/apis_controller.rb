class Api::ApisController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]
    skip_before_action :verify_authenticity_token 
    http_basic_authenticate_with name: "pedro", password: "yanez"

    def index
      array = []
      Tweet.all.each do |tweet|
          array << {:id => tweet.id, :content => tweet.content, :user_id => tweet.user_id, :likes_count => tweet.likes.count, :retwitted_from => tweet.rt_ref} 
      end
      @tweets = array
      render json: @tweets.last(50)
    end

    def date
        first_date = params[:date1]
        last_date = params[:date2]
        @tweets = Tweet.where(:created_at => first_date..last_date)
        render json: @tweets
    end
  
    def show
    end
  
    def create
      @tweet = Tweet.new(content: params[:content], user_id: params[:user_id])
  
      if @tweet.save
        render json: @tweet, status: :created
      else
        render json: @tweet.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @tweet.update(tweet_params)
        render json: @tweet, status: :ok
      else
        render json: @tweet.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @tweet.destroy
      head :no_content
    end
  
    private
    def set_tweet
        @tweet = Tweet.find(params[:id])
    end
  
    def tweet_params
        params.require(:tweet).permit(:email, :password, :user_name, :tweet, :retweet, :likes)
    end
end
