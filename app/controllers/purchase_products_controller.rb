class PurchaseProductsController < ApplicationController

  before_action :require_login

  def create
    if check_age(Product.find(params[:id]), calculate_age(current_user.birthday))
      purchase_product = PurchaseProduct.new(purchase_id: current_user.purchases.find_by(bought: false).id,
                                             product_id: params[:id],
                                             quantity: params[:quantity])
      add_to_price_tag(Product.find(params[:id].to_f), params[:quantity].to_f)
      begin
        purchase_product.save!
        flash[:notice] = 'Produto adicionado ao carrinho com sucesso!'
        redirect_to cart_path
      rescue => err
        print err
        remove_from_price_tag(Product.find(params[:id].to_f), params[:quantity].to_f)
        flash[:notice] = 'Algo deu errado!'
        redirect_to product_path(params[:id])
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    purchase_product = PurchaseProduct.find(params[:id])
    remove_from_price_tag(purchase_product.product, purchase_product.quantity)
    begin
      purchase_product.destroy!
      flash[:notice] = 'Produto retirado do carrinho com sucesso!'
      redirect_to cart_path
    rescue => err
      add_to_price_tag(purchase_product.product, purchase_product.quantity)
      flash[:notice] = 'Algo deu errado!'
      print err
      redirect_to cart_path
    end
  end

  def update
    purchase_product = PurchaseProduct.find(params[:id])
    change_price_tag(purchase_product.product, params[:quantity].to_i, purchase_product.quantity)
    begin
      purchase_product.update!(quantity: params[:quantity].to_i)
      flash[:notice] = 'Carrinho atualizado com sucesso!'
    rescue => err
      change_price_tag(purchase_product.product, purchase_product.quantity, params[:quantity].to_i)
      flash[:notice] = 'Algo deu errado!'
      print err
    ensure
      redirect_to cart_path
    end
  end

  private
  def add_to_price_tag (product, quantity)
    cart = current_user.purchases.find_by(bought: false)
    price_tag = cart.price + (product.value * quantity)
    begin
      cart.update!(price: price_tag)
    rescue => err
      print err
    end
  end

  def remove_from_price_tag (product, quantity)
    cart = current_user.purchases.find_by(bought: false)
    price_tag = cart.price - (product.value * quantity)
    begin
      cart.update!(price: price_tag)
    rescue => err
      print err
    end
  end

  def change_price_tag (product, quantity, original_quantity)
    cart = current_user.purchases.find_by(bought: false)
    price_tag = cart.price + (product.value * (quantity - original_quantity))
    begin
      cart.update!(price: price_tag)
    rescue => err
      print err
    end
  end

  def check_age (product, age)
    if age < 18 and product.drink_type.alcoholic
      flash[:notice] = 'Você não é maior do idade!'
      return false
    else
      return true
    end
  end
end
