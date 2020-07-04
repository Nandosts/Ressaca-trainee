class PurchasesController < ApplicationController
  before_action :require_login
  before_action :check_funds, only: :buy

  def show
    @purchase = Purchase.find(params[:id])
  end

  def cart
    @cart = current_user.purchases.find_by(bought: false)
  end

  def index
    @purchases = current_user.purchases.find_by(bought: true)
  end

  def buy
    cart = current_user.purchases.find_by(bought: false)
    price = cart.price
    pay_up(price)
    begin
      cart.update!(bought: true)
      flash[:notice] = 'Compra realizada com sucesso!'
      create_cart
      redirect_to root_path
    rescue => err
      print err
      flash[:notice] = 'Algo deu errado!'
      redirect_to cart_path
    end
  end

  private
  def check_funds
    cart = current_user.purchases.find_by(bought: false)
    money = current_user.money
    if money < cart.price
      flash[:notice] = 'Você não tem dinheiro suficiente para realizar essa compra.'
      redirect_to perfil_user_path
    end
  end

  def pay_up (price)
    user = current_user
    result = user.money - price
    begin
      user.update!(money: result)
    rescue => err
      print err
    end
  end
end
