class SessionsController < ApplicationController

  def new
  end

  def create

    if(login(params[:email], params[:password]))
      flash[:notice] = "Bem vindo #{current_user.name}!"
      redirect_to root_path
    else
      flash[:notice] = 'Usuário e senha não conferem! Tente novamente.'
      render 'new'
    end
  end

  def destroy
    logout
    flash[:notice] = 'Usúario deslogado. Até a próxima!'
    redirect_to root_path
  end

end
