class UsersController < ApplicationController
  
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
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.update(user_params)
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
  
end
