module UniversalAr::Concerns::Configurable

  extend ActiveSupport::Concern

  included do
    
    has_many :configurations, class_name: 'UniversalAr::Configuration', as: :subject
    has_many :config_strings, class_name: 'UniversalAr::ConfigString', as: :subject
    has_many :config_integers, class_name: 'UniversalAr::ConfigInteger', as: :subject
    has_many :config_booleans, class_name: 'UniversalAr::ConfigBoolean', as: :subject
    has_many :config_dates, class_name: 'UniversalAr::ConfigDate', as: :subject

    def update_configs!(config_params)
      config_params.each do |config|
        value = config[1].to_s
        #find the config
        configuration = UniversalAr::Configuration.find(config[0])
        if !configuration.nil?
          configuration.create_or_update_config(self, config[1])
        end
      end
    end
    
    def config_value_model(data_type)
      case data_type.to_s.titleize
      when 'String'
        return ::UniversalAr::ConfigString
      when 'Integer'
        return ::UniversalAr::ConfigInteger
      when 'Boolean'
        return ::UniversalAr::ConfigBoolean
      when 'Date'
        return ::UniversalAr::ConfigDate 
      end
    end
    
    def config_value(key, data_type)
      c = self.config_value_model(data_type).find_by(subject: self, key: key)
      return nil if c.nil?
      return c.value
    end
    
    #find the relevant config entry and make sure they have entered one
    scope :with_config_value, ->(configuration){
      joins("INNER JOIN `#{configuration.config_class.table_name}` ON `#{configuration.config_class.table_name}`.configuration_id = #{configuration.id} 
        AND `#{configuration.config_class.table_name}`.`subject_id` = #{self.table_name}.`id` AND `#{configuration.config_class.table_name}`.`subject_type` = '#{self.class_name}'").
      where("`#{configuration.config_class.table_name}`.`value` IS NOT NULL AND `#{configuration.config_class.table_name}`.`value` <> ''")
    }
  
  end
end
