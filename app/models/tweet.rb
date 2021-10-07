class Tweet < ApplicationRecord
    has_one_attached :photo

    belongs_to :user
    has_many :likes, dependent: :destroy
    validates :content, presence: true
    has_many :tweet_hash_tags
    has_many :hash_tags, through: :tweet_hash_tags
    after_commit :create_hash_tags, on: :create
    has_many :retweets, class_name: 'Tweet', foreign_key: 'rt_ref', dependent: :destroy

    def retweet_ref
        Tweet.find(self.rt_ref)
    end

    def create_hash_tags
        extract_name_hash_tags.each do |name|
          hash_tags.create(name: name)
        end
    end
    
    def extract_name_hash_tags
        content.to_s.scan(/#\w+/).map{|name| name.gsub("#", "")}
    end
    

end
