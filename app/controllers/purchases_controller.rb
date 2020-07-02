class PurchasesController < ApplicationController
  before_action :require_login

  def show
    @purchase = Purchase.find(params[:id])
  end

  def cart
    @cart = current_user.purchases.find_by(bought: false)
  end

  def index
    @purchases = current_user.purchases.find_by(bought: true)
  end

end
