require_dependency "universal_ar/application_controller"

module UniversalAr
  class RolesController < ApplicationController

    before_action :authenticate_user!, :require_sysadmin!
    before_action :find_role, only: [:users, :add_user, :remove_user, :edit, :update, :invite_user, :show, :destroy]

    def index
      @roles = find_roles
    end

    def create
      @role = ::UniversalAr::Role.new(role_params)
      @role.scope = universal_scope
      if @role.save
        redirect_to universal_ar.edit_role_path(@role)
      else
        redirect_to universal_ar.roles_path
      end

    end

    def show
      render_show @role
    end

    def users
      @users = @role.users
      render layout: false
    end

    def add_user
      @user = User.find(params[:user_id])
      @user.roles << @role if !@user.nil? and !@user.roles.include?(@role)
      @users = @role.users
      render layout: false
    end

    def remove_user
      @user = User.find(params[:user_id])
      @user.roles.destroy(@role) if !@role.nil? and !@user.nil?
      render layout: false
    end

    def edit
      #load the functions
      @functions = YAML.load(File.read("#{Rails.root}/config/universal_functions.yml")).symbolize_keys
    end

    def update
      @role.update(role_params)
      functions = params[:functions]
      @role.functions.destroy_all
      if params[:functions]
        params[:functions].each do |function|
          context = function
          codes = params[:functions][function]
          codes.each do |code|
            f = UniversalAr::Function.find_or_create_by(scope: universal_scope, context: context, code: code)
            @role.functions << f
          end
        end
      end
      redirect_to universal_ar.roles_path
    end

    def destroy
      if !@role.nil?
        @role.users.map{|u| u.pull(_ugid: @role.id.to_s);u.update_role_functions}
        if @role.destroy!

        end
      end
      redirect_to universal_ar.roles_path
    end

    private
    def role_params
      params.require(:role).permit(:name, :notes)
    end

    def find_role
      @role = ::UniversalAr::Role.find(params[:id])
    end

    def find_roles
      roles = ::UniversalAr::Role.all
      roles = roles.scoped_to(universal_scope) if !universal_scope.nil?
      return roles
    end

  end
end
