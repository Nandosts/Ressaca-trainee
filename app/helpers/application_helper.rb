module ApplicationHelper

    include Pagy::Frontend

    def human_boolean(boolean)
        boolean ? 'Sim' : 'Não'
    end

end
