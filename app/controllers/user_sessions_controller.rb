class UserSessionsController < ApplicationController
  def new; end

  def create
    if login(params[:email], params[:password])
      flash[:success] = "Logado com sucesso"
      redirect_to root_path
    else
      flash[:error] = "Credenciais inválidas"
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
