module ProductsHelper

    include ActionView::Helpers::NumberHelper

    def number_to_reais(number)
        number_to_currency(number, :unit => "R$ ", :separator => ",", :delimiter => ".")
    end

end
