class PurchaseProductsController < ApplicationController

  before_action :require_login

  def create
    # Checagem se o usuário é maior de idade
    if check_age(Product.find(params[:id]), calculate_age(current_user.birthday))

      # Buscando se o produto já está no carrihno
      purchase_product = current_user.purchases.find_by(bought: false)
                             .purchase_products.find_by(product_id: params[:id])

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

  # Adiciona um produto ao carrinho
  def new_product_on_cart
    purchase_product = PurchaseProduct.new(purchase_id: current_user.purchases.find_by(bought: false).id,
                                           product_id: params[:id],
                                           quantity: params[:quantity])
    begin
      purchase_product.save!
      change_price_tag(Product.find(params[:id].to_f).value, params[:quantity].to_f)
      flash[:notice] = 'Produto adicionado ao carrinho com sucesso!'
      redirect_to cart_path
    rescue => err
      print err
      flash[:warning] = 'Algo deu errado!'
      redirect_to product_path(params[:id])
    end
  end

  # Aumenta a quantidade de um item no carrinho
  def increase_product_on_cart(purchase_product)

    new_quantity = purchase_product.quantity.to_i + params[:quantity].to_f
    begin
      purchase_product.update!(quantity: new_quantity)
      change_price_tag(Product.find(params[:id].to_f).value, params[:quantity].to_f)
      flash[:notice] = 'Produto adicionado ao carrinho com sucesso!'
      redirect_to cart_path
    rescue => err
      print err
      flash[:warning] = 'Algo deu errado!'
      redirect_to product_path(params[:id])
    end
  end

  def destroy
    purchase_product = PurchaseProduct.find(params[:id])
    begin
      purchase_product.destroy!
      change_price_tag(-purchase_product.product.value, purchase_product.quantity)
      flash[:notice] = 'Produto retirado do carrinho com sucesso!'
      redirect_to cart_path
    rescue => err
      flash[:warning] = 'Algo deu errado!'
      print err
      redirect_to cart_path
    end
  end

  def update
    purchase_product = PurchaseProduct.find(params[:id])

    # Salvando a quantidade anterior de produtos
    old_quantity = purchase_product.quantity
    begin
      purchase_product.update!(quantity: params[:quantity].to_i)
      # Removendo o preço da quantidade de produtos anterior e adicionando a nova quantidade
      change_price_tag(purchase_product.product.value,params[:quantity].to_i - old_quantity)

      flash[:notice] = 'Carrinho atualizado com sucesso!'
    rescue => err
      flash[:warning] = 'Algo deu errado!'
      print err
    ensure
      redirect_to cart_path
    end
  end

  # Altera o valor total no carrinho/compra para o valor original + (valor do produto * quantidade)
  private
  def change_price_tag (product_value, quantity)
    cart = current_user.purchases.find_by(bought: false)
    price_tag = cart.price + (product_value * quantity)
    begin
      cart.update!(price: price_tag)
    rescue => err
      print err
    end
  end

  # Retorna false se a idade for menor de 18 e o produto for alcoolico
  def check_age (product, age)
    if age < 18 and product.drink_type.alcoholic
      flash[:warning] = 'Você não é maior do idade!'
      return false
    else
      return true
    end
  end
end
