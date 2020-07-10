class DrinkTypesController < ApplicationController

    before_action :authorize_admin, only: [:new, :edit, :update, :destroy, :create]
    def index
        @drink_types = DrinkType.all
    end

    def new
        @drink_type = DrinkType.new
        @page_title = "Novo Tipo de Bebida"
    end

    def create
        drink_type = DrinkType.new(drink_types_params)
        begin
            drink_type.save!
            flash[:notice] = "Tipo de bebida #{drink_type.name} criado com sucesso!"
            redirect_to drink_type_path(drink_type)
        rescue => err
            flash[:notice] = err
            redirect_to new_drink_type_path
        end
    end

    def edit
        @drink_type = DrinkType.find(params[:id])
        @page_title = "Editar Tipo de Bebida"
    end

    def update
        drink_type = DrinkType.find(params[:id])
        begin
            drink_type.update!(drink_types_params)
            flash[:notice] = "Tipo de bebida #{drink_type.name} modificado com sucesso!"
            redirect_to drink_type_path(drink_type)
        rescue => err
            flash[:notice] = err
            redirect_to edit_drink_type_path
        end
    end

    def show
        @drink_type = DrinkType.find(params[:id])
    end

    def destroy
        drink_type = DrinkType.find(params[:id])
        begin
            drink_type.destroy!
            flash[:notice] = "Tipo de bebida #{drink_type.name} apagado com sucesso!"
        rescue => err
            flash[:notice] = err
        ensure
            redirect_to drink_types_path
        end
    end

    private

    def drink_types_params
        params.require('drink_type').permit(:name, :alcoholic)
    end

end
