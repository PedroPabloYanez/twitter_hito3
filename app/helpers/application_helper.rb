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
end
