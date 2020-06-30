class PurchasesController < ApplicationController
  def create
    cart = Purchase.new({user_id: current_user.id, bought: true})
    cart.save
  end

  def show
    @purchase = Purchase.find(params[:id])
  end

  def cart
    @cart = Purchase.find_by(bought: false)
  end

  def index
    @purchases = Purchase.find_by(bought: true)
  end
end
