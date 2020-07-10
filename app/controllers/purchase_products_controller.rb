class PurchaseProductsController < ApplicationController

  before_action :require_login

  def create

    # Checagem se o usuário é maior de idade
    if check_age(Product.find(params[:id]), calculate_age(current_user.birthday))

      # Buscando se o produto já está no carrihno
      purchase_product = current_user.purchases.find_by(bought: false).purchase_products.find_by(product_id: params[:id])

      # Produto é novo no carrinho
      if purchase_product == nil
        new_product_on_cart
        # Produto já está no carrinho
      else
        increase_product_on_cart(purchase_product)
      end
    else
      redirect_to root_path
    end
  end

  # Adicionoa um produto ao carrinho
  def new_product_on_cart
    purchase_product = PurchaseProduct.new(purchase_id: current_user.purchases.find_by(bought: false).id,
                                           product_id: params[:id],
                                           quantity: params[:quantity])
    begin
      purchase_product.save!
      add_to_price_tag(Product.find(params[:id].to_f), params[:quantity].to_f)
      flash[:notice] = 'Produto adicionado ao carrinho com sucesso!'
      redirect_to cart_path
    rescue => err
      print err
      flash[:notice] = 'Algo deu errado!'
      redirect_to product_path(params[:id])
    end
  end

  # Aumenta a quantidade de um item no carrinho
  def increase_product_on_cart(purchase_product)

    new_quantity = purchase_product.quantity + params[:quantity].to_f
    begin
      purchase_product.update!(quantity: new_quantity)
      add_to_price_tag(Product.find(params[:id].to_f), params[:quantity].to_f)
      flash[:notice] = 'Produto adicionado ao carrinho com sucesso!'
      redirect_to cart_path
    rescue => err
      print err
      flash[:notice] = 'Algo deu errado!'
      redirect_to product_path(params[:id])
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

  # Retorna false se a idade for menor de 18 e o produto for alcoolico
  def check_age (product, age)
    if age < 18 and product.drink_type.alcoholic
      flash[:notice] = 'Você não é maior do idade!'
      return false
    else
      return true
    end
  end
end
