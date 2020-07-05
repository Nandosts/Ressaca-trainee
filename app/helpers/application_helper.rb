module ApplicationHelper

    include Pagy::Frontend
    include ActionView::Helpers::NumberHelper

    def human_boolean(boolean)
        boolean ? 'Sim' : 'Não'
    end

    def is_admin?
        if logged_in? == true and current_user.admin? == true
            return true
        else
            return false
        end
    end

    def number_to_reais(number)
        number_to_currency(number, :unit => "R$ ", :separator => ",", :delimiter => ".")
    end

end
