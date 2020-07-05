module ProductsHelper



    def stock_information(stock)
        if stock > 25
            return "Em estoque"
        elsif stock > 0
            return "#{stock} itens restantes"
        else
            return "Produto indisponível"
        end
    end

end
