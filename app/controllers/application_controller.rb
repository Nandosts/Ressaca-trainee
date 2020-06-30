class ApplicationController < ActionController::Base
  def homepage; end

  def authorize_admin

    if current_user.nil?
      flash[:notice] = "É necessário logar para acessar essa página"
      redirect_to root_path
    elsif current_user.admin? == false
      flash[:notice] = "Página restrita ao Administrador!!!"
      redirect_to root_path
      end
  end
end
