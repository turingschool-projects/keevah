class UsersController < ApplicationController
  protect_from_forgery with: :null_session
  load_and_authorize_resource

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  before_action :current_user, only: [:show, :edit, :update]

  def index
  end

  def new
  end

  def create
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'User created.'
    else
      flash.now[:notice] = 'User could not be created.'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username,
                                 :password, :password_confirmation)
  end
end
