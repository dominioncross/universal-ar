require_dependency "universal_ar/application_controller"

module UniversalAr
  class ConfigsController <  UniversalAr::ApplicationController
    
    skip_before_action :validate_scope
    
    def create
      model = params[:subject_type].classify.constantize.find(params[:subject_id])
      if !model.nil?
        params[:config].to_unsafe_h.each do |config|
          value = config[1].to_s
          if !config[1].blank?
            configuration = UniversalAr::Configuration.find(config[0])
            if !configuration.nil?
              key = configuration.key
              case configuration.data_type.to_s
              when 'Date'
                model.config_dates.create configuration: configuration,
                                          key: key,
                                          value: value.to_date
              when 'String'
                c = model.config_strings.create configuration: configuration,
                                              key: key,
                                              value: value.to_s
                puts c.errors.to_json
              end
            end
          end
        end
      end
      render json: {}
    end
    
  end
end