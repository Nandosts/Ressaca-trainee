class PurchasesController < ApplicationController
  before_action :require_login
  before_action :check_funds, only: :buy
  before_action :check_stock, only: :buy

  def show
    @purchase = Purchase.find(params[:id])
  end

  def cart
    @cart = current_user.purchases.find_by(bought: false)
  end

  def index
    @purchases = current_user.purchases.where('bought = true')
  end

  def buy
    cart = current_user.purchases.find_by(bought: false)
    price = cart.price
    pay_up(price)
    change_stock(cart, true)
    begin
      cart.update!(bought: true)
      flash[:notice] = 'Compra realizada com sucesso!'
      create_cart
      redirect_to root_path
    rescue => err
      print err
      change_stock(cart, false)
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

  def check_stock
    flash[:notice] = ''
    cart = current_user.purchases.find_by(bought: false)
    cart.purchase_products.each do |associative|
      available = associative.product.quantity
      requested = associative.quantity
      if requested > available
        flash[:notice] << "Não pussimos #{associative.product.name} o suficiente para atender seu pedido \n"
        redirect_to cart_path
      end
    end
  end

  def change_stock (cart, bool)
    if bool
      cart.purchase_products.each do |associative|
        product = associative.product
        new_quantity = product.quantity - associative.quantity
        begin
          product.update!(quantity: new_quantity)
        rescue => err
          print err
        end
      end
    else
      cart.purchase_products.each do |associative|
        product = associative.product
        new_quantity = product.quantity + associative.quantity
        begin
          product.update!(quantity: new_quantity)
        rescue => err
          print err
        end
      end
    end
  end
end
