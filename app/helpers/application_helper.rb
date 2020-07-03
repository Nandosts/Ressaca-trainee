module ApplicationHelper

    include Pagy::Frontend
    include ActionView::Helpers::NumberHelper

    def human_boolean(boolean)
        boolean ? 'Sim' : 'Não'
    end

    def number_to_reais(number)
        number_to_currency(number, :unit => "R$ ", :separator => ",", :delimiter => ".")
    end

end
