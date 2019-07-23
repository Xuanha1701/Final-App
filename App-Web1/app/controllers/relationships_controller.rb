class RelationshipsController < ApplicationController

  def follow_user
    @user = User.find_by(id: params[:id])
    if current_user.follow @user.id
     redirect_to root_path }
      end
    end
  end

  def unfollow_user
    @user = User.find_by(id: params[:id])
    if current_user.unfollow @user.id
      redirect_to root_path
      end
    end
  end

end