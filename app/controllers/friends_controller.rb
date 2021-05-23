class FriendsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def follow
        @followed = User.find(params[:id])
        @friend = Friend.new(user_id: current_user.id, friend_id: @followed.id)
        @friend.save
        redirect_to root_path, notice: "you are now following #{@followed.user_name}"
    end

    def unfollow
        friend = Friend.find_by(friend_id: params[:id], user_id: current_user)
        friend.destroy 
        redirect_to root_path, notice: "ya no sigues a este usuario"
    end   
    
    # def follow
    #     @user = User.find(params[:id])
    #     current_user.followees << @user
    #     redirect_back(fallback_location: user_path(@user))
    #   end
      
    #   def unfollow
    #     @user = User.find(params[:id])
    #     current_user.followed_users.find_by(followee_id: @user.id).destroy
    #     redirect_back(fallback_location: user_path(@user))
    #   end
end