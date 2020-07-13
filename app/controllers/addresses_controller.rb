class AddressesController < ApplicationController

  def create
    address = Address.new(address_args)
    address.user = current_user
    address.visible = true

    begin
      verify_cep(address.cep)
      address.save!
      flash[:notice] = 'Endereço criado com sucesso!'
    rescue => exc
      flash[:warning] = exc
    ensure
      redirect_to perfil_user_path
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def new
    @address = Address.new
  end

  def show
    @address = Address.find(params[:id])
  end

  def destroy
    @address = Address.find(params[:id])
    begin
      @address.update!(visible: false)
      flash[:notice] = 'Endereço apagado com sucesso!'
      redirect_to perfil_user_path
    rescue => exc
      flash[:warning] = 'Um erro ocorreu'
      puts exc
      redirect_to perfil_user_path
    end
  end

  def update
    address = Address.find(params[:id])
    begin
      verify_cep(params[:address][:cep])
      address.update!(address_args)
      flash[:notice] = 'Endereço editado com sucesso!'
    rescue => exc
      flash[:warning] = exc
      puts exc
    ensure
      redirect_to perfil_user_path
    end
  end

  def verify_cep(cep)
    # Checando o tamanho do cep e se contem o "-"
    if cep.length == 9 && cep[5] == '-'
      # Checando se o CEP contem apenas números
      if cep[0..4].scan(/\D/).empty? == false || cep[6..8].scan(/\D/).empty? == false
        raise "Formato inválido de CEP, favor inserir no formato: XXXXX-XXX"
      end
    else
      raise "Formato inválido de CEP, favor inserir no formato: XXXXX-XXX"
    end
  end

  private
  def address_args
    params.require('address').permit(:cep, :address)
  end
end
