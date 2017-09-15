module UniversalAr
  class ApplicationController < ActionController::Base
    
    before_action :validate_scope
    helper_method :universal_scope
    
    def universal_scope
      @universal_scope ||= UniversalAr::Scope.find_by_domain(request.host)
    end
    
    def validate_scope
      if universal_scope.nil? and controller_name != 'setup'
        redirect_to universal_ar.setup_path
      end
    end
    
    def require_sysadmin!
      if !signed_in? or !current_user.can?(:sysadmin)
        render file: "#{Rails.root}/public/404.html", status: 404, layout: false
      end
    end
    
  end
end
