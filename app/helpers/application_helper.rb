module ApplicationHelper

    include Pagy::Frontend

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

end
