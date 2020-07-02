module ProductsHelper

    include ActionView::Helpers::NumberHelper

    def number_to_reais(number)
        number_to_currency(number, :unit => "R$ ", :separator => ",", :delimiter => ".")
    end

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
