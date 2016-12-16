require_dependency "universal_ar/application_controller"

module UniversalAr
  class UsersController < ApplicationController
    
    def autocomplete
      @users = User.all
      if universal_scope
        @users = @users.scoped_to(universal_scope)
      end
      if !params[:term].blank?
        @users = @users.where("email like ?", "%#{params[:term]}%")
      end
      json = @users.map{|c| {label: "#{c.name} - #{c.email}", value: c.id.to_s}}
      render json: json.to_json
    end
    
  end
end