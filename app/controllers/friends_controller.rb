class FriendsController < ApplicationController
  def new
    @friend = Friend.new
  end

  def create
    @friends_list = Friends_list.new
    @friends_list.user_id = current_user.id
    @friend = Friend.new(friend_params)
    @friend.user_id = current_user.id
    @friends_list.friend_id = @friend.user_id.id

    if @friends_list && @friend.save
      redirect_to @friend, notice: 'Friend was successfully added. 🟢'
    else
      render 'new', notice: 'Error, friend not added. 🔴'
    end
  end

  def destroy
    @friend = Friend.find(params[:id])
    @friend.destroy
    redirect_to friends_path, notice: 'Friend was successfully removed. 🟢'
  end

  private
  def friend_params
    params.require(:friend).permit(:user_id)
  end
end
