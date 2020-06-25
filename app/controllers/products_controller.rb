class ProductsController < ApplicationController

    def index
        @products = Product.all
    end

    def new
        @product = Product.new
    end

    def create
        product = Product.new(products_params)
        begin
            product.save!
            flash[:notice] = "Produto #{product.name} criado com sucesso!"
            redirect_to product_path(product)
        rescue => err
            flash[:notice] = err
            redirect_to new_product_path
        end
    end

    def edit
        @product = Product.find(params[:id])
    end

    def update
        product = Product.find(params[:id])
        begin
            product.update!(products_params)
            flash[:notice] = "Produto #{product.name} modificado com sucesso!"
            redirect_to product_path(product)
        rescue => err
            flash[:notice] = err
            redirect_to edit_product_path
        end
    end

    def show
        @product = Product.find(params[:id])
    end

    def destroy
        product = Product.find(params[:id])
        begin
            product.destroy!
            flash[:notice] = "Produto #{product.name} apagado com sucesso!"
        rescue => err
            flash[:notice] = err
        ensure
            redirect_to root
        end
    end

    private

    def products_params
        params.require('product').permit(:name, :value, :volume, :quantity, :favorite, :drink_type_id, :description, :photo)
    end
    
end
