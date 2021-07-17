module ApplicationHelper
    def like(tweet, user)
        tweet.likes.find{|like| like.user_id == user.id} 
    end    

    def pre_follow(user)
        current_user.friends.find { |friend| friend.friend_id == user.id }
    end

    def name(id)
        rt = Tweet.find(id) 
        rt.user.user_name
    end

    def photo(id)
        ph = Tweet.find(id) 
        ph.user.user_photo
    end

    def count_retweet(user)
        Tweet.where(user_id: user.id).where.not(retweet:nil).pluck(:retweet).sum
    end

    def count_like(user)
        user.likes.count
        #Like.where(user_id: user.id).count
    end

    def get_friends(user, dude)
        if dude 
            user.friends.count
            #t = Friend.where(user_id: user.id).count
        else    
            t = Friend.where(friend_id: user.id).count
        end
    end

    def image(tweet)
        if tweet.image
            true
        else
            false
        end
    end

end
