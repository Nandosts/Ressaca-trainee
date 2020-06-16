class AddressesController < ApplicationController

  def create
    address = Address.new(user_args)
    begin
      address.save!
      flash[:notice] = 'Endereço criado com sucesso!'
      redirect_to root_path
    rescue => exc
      flash[:notice] = exc
      redirect_to new_adresses_path
    end
  end

  def new
    @address = Address.new
  end

  def show
    @address = Address.find(params[:id])
  end

  def destroy
    address = Address.find(params[:id])
    begin
      address.destroy!
      flash[:notice] = 'Endereço apagado com sucesso!'
      redirect_to addresses_path
    rescue => exc
      flash[:notice] = exc
      puts exc
      redirect_to new_addresses_path
    end
  end

  def edit
    address = Address.find(params[:id])
    begin
      address.update!(address_parameters)
      flash[:notice] = 'Endereço editado com sucesso!'
      redirect_to addresses_path
    rescue => exc
      flash[:notice] = exc
      puts exc
      redirect_to edit_addresses_path
    end
  end

  private
  def user_args
    params.require('address').permit(:cep, :address, :user_id)
  end
end
