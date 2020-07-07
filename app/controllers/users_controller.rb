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
    user.money = 0
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
    @user = current_user
  end

  def add_money_logic
    @user = current_user
    begin
      puts params
      new_money = @user.money.to_f + params[:money].to_f
      @user.update_attributes!(money: new_money)
      redirect_to perfil_user_path
    rescue => err
      flash[:notice] = err
    end

  end

  private
  def user_args
    params.require(:user).permit(:name, :password, :email, :password_confirmation, :birthday)
  end

  def not_authenticated
    redirect_to login_path, alert: "Por Favor faça login"
  end
end
