class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  
  def show # 追加
   @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user # ここを修正
    else
      render 'new'
    end
  end


#  http://servername/user/1/edit  
  def edit
    check_user
  end
  
  def update
    check_user
    if @user.update(user_profile)
    #成功した場合、ユーザーページにリダイレクト
    redirect_to @user
    else
     flash[:alert] = "update failed"
     render "edit"
    end
  end
  
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
  
  def user_profile
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :biography)
  end
  
  def check_user
    @user = User.find(params[:id])
    if (current_user != @user)
      redirect_to root_path
    end
  end
  
end
