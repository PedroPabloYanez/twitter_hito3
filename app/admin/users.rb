ActiveAdmin.register User do
  actions :all, only: [:update, :destroy, :show]
  permit_params :user_name, :email, :user_photo

  index do
    column 'User Name', :user_name

    column 'Tweets Quantity' do |user|
      user.tweets.count
    end

    column 'Likes Quantity' do |user|
      user.likes.count
    end

    column 'Retweets' do |user|
      user.tweets.where.not(rt_ref: id).count
    end
  
    actions
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :user_name, :user_photo
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :user_name, :user_photo]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
