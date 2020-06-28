class UsersController < ApplicationController
  before_action :require_login, only: :show

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def show; end

  def create
    user = User.new(user_args)
    begin
      user.save!
      flash[:notice] = 'Usuário criado com sucesso!'
      redirect_to root_path
    rescue => err
      flash[:notice] = err
      redirect_to new_user_path
    end
  end

  def update
    user = User.find(params[:id])
    begin
      user.update!(user_args)
      flash[:notice] = 'Usuário editado com sucesso'
      redirect_to root_path
    rescue => err
      flash[:notice] = err
    end
  end

  def destroy
    user = User.find(params[:id])
    begin
      user.destroy!
      flash[:notice] = 'Usuário deletado com sucesso'
    end
  end

  def add_money
    user = User.find(params[:id])
    begin
      user.money = params[:money]
    end
  end

  private
  def user_args
    params.require(:user).permit(:name, :password, :email, :password_confirmation)
  end

  def not_authenticated
    redirect_to login_path, alert: "Por Favor faça login"
  end
end
