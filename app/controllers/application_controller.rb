class ApplicationController < ActionController::Base

  include Pagy::Backend

  before_action :get_drink_types

  def homepage
    @pagy, @records = pagy(Product.all)
  end

  def authorize_admin
    if current_user.nil?
      flash[:notice] = "É necessário logar para acessar essa página"
      redirect_to root_path
    elsif current_user.admin? == false
      flash[:warning] = "Página restrita ao Administrador!!!"
      redirect_to root_path
      end
  end

  def create_cart
    cart = Purchase.new({user_id: current_user.id, bought: false, price: 0})
    cart.save
  end

  def calculate_age (date)
    ((Time.zone.now - date.to_time) / 1.year.seconds).floor
  end

  private
  
  def get_drink_types
    @drink_types_search = DrinkType.all
  end

end
