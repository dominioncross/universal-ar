require_dependency "universal_ar/application_controller"

module UniversalAr
  class SetupController < ApplicationController
   
    def show
      redirect_to '/' if !universal_scope.nil?
    end
    
    def create
      scope = UniversalAr::Scope.find_or_create_by(params.require(:scope).permit(:name))
      params[:domain][:all].split("\r\n").each do |domain|
        scope.add_domain!(domain.strip.downcase)
      end
      user = User.new params.require(:user).permit(:email, :password)
      user.scope = scope
      user.password_confirmation = user.password
      if user.save
        
        user.save_comment!("Administrator account created: #{user.to_json}", user, scope, :setup)
        #create the sysadmin role
        role = UniversalAr::Role.create name: :sysadmin, scope: scope
        if !role.nil?
          role.flag!(:locked)
          user.roles << role
        end
        
        #create the function to manage roles:
        function = UniversalAr::Function.create context: :sysadmin, code: :manage_roles, scope: scope
        role.functions << function
      end
      scope.save_comment!("Setup complete:\r\n#{scope.to_json}", user, scope)
      redirect_to '/'
    end
    
  end
end
