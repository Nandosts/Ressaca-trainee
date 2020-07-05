module ProductsHelper

    def stock_information(stock)
        if stock > 25
            return '<p class="in-stock">Em estoque</p>'.html_safe
        elsif stock > 0
            return ('<p class="low-stock">Apenas ' + stock.to_s + ' itens restantes</p>').html_safe
        else
            return '<p class="no-stock">Produto indisponível<p>'.html_safe
        end
    end

end
