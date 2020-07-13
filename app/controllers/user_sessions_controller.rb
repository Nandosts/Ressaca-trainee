class UserSessionsController < ApplicationController
  def new; end

  def create
    if login(params[:email], params[:password])
      flash[:notice] = "Logado com sucesso"
      redirect_to root_path
      if current_user.purchases.find_by(bought: false).nil?
        create_cart
      end
    else
      flash[:warning] = "Credenciais inválidas"
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
