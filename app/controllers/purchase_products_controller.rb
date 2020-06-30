class PurchaseProductsController < ApplicationController
  def create
    purchase_product = PurchaseProduct.new(purchase_id: current_user.purchases.find_by(bought: false),
                                           product_id: params[:product_id],
                                           quantity: params[:quantity])
    begin
      purchase_product.save!
      flash[:notice] = 'Produto adicionado ao carrinho com sucesso!'
      redirect_to root_path
    rescue => err
      flash[:notice] = 'Algo deu errado!'
      print err
      redirect_to product_path(params[:product_id])
    end
  end

  def destroy
    purchase_product = PurchaseProduct.find(params[:id])
    begin
      purchase_product.destroy!
      flash[:notice] = 'Produto retirado do carrinho com sucesso!'
    rescue => err
      flash[:notice] = 'Algo deu errado!'
      print err
    ensure
      redirect_to root_path
    end
  end
end
