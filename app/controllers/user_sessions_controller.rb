class UserSessionsController < ApplicationController
  def new; end

  def create
    if login(params[:email], params[:password])
      flash[:notice] = "Logado com sucesso"
      redirect_to root_path
    else
      flash[:notice] = "Credenciais inválidas"
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
