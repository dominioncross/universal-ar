require_dependency "universal_ar/application_controller"

module UniversalAr
  class ConfigurationsController < ApplicationController

    skip_before_action :validate_scope
    before_action :find_subject
    
    def create
      if !@subject.nil?
        @configuration = @subject.configurations.create params.require(:configuration).permit(:class_name, :key, :title, :data_type)
      end
      puts @configuration.errors.to_json
      render json: {configuration: @configuration.to_json}
    end
    
    private
    def find_subject
      if !params[:subject_type].blank? and params[:subject_type] != 'undefined' and !params[:subject_id].blank? and params[:subject_id] != 'undefined'
        @subject = params[:subject_type].classify.constantize.find(params[:subject_id])
      end      
    end
    
  end
end