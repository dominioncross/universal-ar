require_dependency "universal_ar/application_controller"

module UniversalAr
  class ConfigsController <  UniversalAr::ApplicationController
    
    skip_before_action :validate_scope
    
    def create
      subject = params[:subject_type].classify.constantize.find(params[:subject_id])
      if !subject.nil?
        if !params[:config].nil?
          params[:config].to_unsafe_h.each do |config|
            value = config[1].to_s
            if !config[1].blank?
              configuration = UniversalAr::Configuration.find(config[0])
              if !configuration.nil?
                key = configuration.key
                case configuration.data_type.to_s
                when 'Date'
                  subject.config_dates.create configuration: configuration,
                                            key: key,
                                            value: value.to_date
                when 'String'
                  c = subject.config_strings.create configuration: configuration,
                                                key: key,
                                                value: value.to_s
                  puts c.errors.to_json
                end
              end
            end
          end
        elsif !params[:config_key].blank? and !params[:data_type].blank?
          subject.set_adhoc_config_value!(params[:config_key], params[:value], params[:data_type])
        end
      end
      render json: {}
    end
    
  end
end