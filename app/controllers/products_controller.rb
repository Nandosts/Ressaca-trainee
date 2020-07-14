class ProductsController < ApplicationController

    before_action :authorize_admin, except: [:show, :search]

    def search
        @drink_types = DrinkType.all

        # Pegar todos os produtos sem ordem ou filtro
        @filtered_products = Product.all

        # Filtrando por nome na busca se necessário
        if params[:search] != nil
            @filtered_products = Product.search(params[:search].downcase)
        end
        
        # Ordenação
        if params[:order] != '0'
            # Ordenar A-Z
            if params[:order] == '1'
                @filtered_products = @filtered_products.order(name: :asc)

            # Ordenar Z-A
            elsif params[:order] == '2'
                @filtered_products = @filtered_products.order(name: :desc)

            # Ordenar por preço crescente
            elsif params[:order] == '3'
                @filtered_products = @filtered_products.order(value: :asc)

            # Ordenar por preço decrescente
            elsif params[:order] == '4'
                @filtered_products = @filtered_products.order(value: :desc)

            # Ordenar por tipo de produto
            elsif params[:order] == '5'
                @filtered_products = @filtered_products.order(:drink_type_id)
            end
        end

        # Filtrando por preço se necessário
        if params[:price] != '0' && params[:price] != nil

            # Extraindo os limites do filtro de preço se selecionado
            min, max = params[:price].split('-')

            # Um valor máximo não foi informado
            if(max == "MAX")
                @filtered_products = @filtered_products.where("value > ?", min.to_i )
            else
                @filtered_products = @filtered_products.where(value: min.to_i..max.to_i)
            end
        end

        # Filtrando por tipo de bebida se necessário
        if params[:type] != nil && params[:type] != '0'
            @filtered_products = @filtered_products.where(:drink_type_id => params[:type])
        end

        # Retirando os produtos que não estão visiveis/foram excluidos
        @filtered_products = @filtered_products.where(visible: true)

        # Atualizando Pagy
        @pagy, @records = pagy(@filtered_products)

        render 'search'
    end

    def index
        @products = Product.where(visible: true)
    end


    def new
        @product = Product.new
        @drink_types = DrinkType.all
        @page_title = "Cadastrar Produto"
    end

    def create
        product = Product.new(products_params)
        product.visible = true
        begin
            product.save!
            flash[:notice] = "Produto #{product.name} criado com sucesso!"
            redirect_to product_path(product)
        rescue => err
            flash[:warning] = err
            redirect_to new_product_path
        end
    end

    def edit
        @product = Product.find(params[:id])
        @drink_types = DrinkType.all
        @page_title = "Editar Produto"
    end

    def update
        product = Product.find(params[:id])
        begin
            product.update!(products_params)
            flash[:notice] = "Produto #{product.name} modificado com sucesso!"
            redirect_to product_path(product)
        rescue => err
            flash[:warning] = err
            redirect_to edit_product_path
        end
    end

    def show
        @product = Product.find(params[:id])
    end

    def destroy
        product = Product.find(params[:id])
        begin
            product.update!(visible: false)
            flash[:notice] = "Produto #{product.name} apagado com sucesso!"
        rescue => err
            flash[:warning] = err
        ensure
            redirect_to products_path
        end
    end

    def favorite
        product = Product.find(params[:id])
        begin
            product.update_attributes!(favorite: !product.favorite)
        rescue => err
            flash[:warning] = err
        ensure
            redirect_to products_path
        end
    end

    private

    def products_params
        unless params['product'][:name].nil?
            params['product'][:name] = params['product'][:name].downcase
        end
        return params.require('product').permit(:name, :value, :volume, :quantity, :favorite, :drink_type_id, :description, :photo)
    end

end
