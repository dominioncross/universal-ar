module UniversalAr::Concerns::Configurable

  extend ActiveSupport::Concern

  included do

    has_many :configurations, class_name: 'UniversalAr::Configuration', as: :subject
    has_many :config_strings, class_name: 'UniversalAr::ConfigString', as: :subject
    has_many :config_integers, class_name: 'UniversalAr::ConfigInteger', as: :subject
    has_many :config_booleans, class_name: 'UniversalAr::ConfigBoolean', as: :subject
    has_many :config_dates, class_name: 'UniversalAr::ConfigDate', as: :subject

    #Update all config passed in via form parameters
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

    #find the corresponding model that is storing this config value
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

    #find the value of config, based on the key and datatype
    def config_value(key, data_type='String')
      c = self.config_value_model(data_type).find_by(subject: self, key: key)
      return nil if c.nil?
      return c.value
    end

    #Create or update config for this model, based on the parent that owns the configuration and the key/ that we are passing
    def set_config_value!(config_parent, key, value)
      #find the configuration
      configuration = config_parent.configurations.find_by(class_name: self.class.to_s, key: key)
      if !configuration.nil?
        configuration.create_or_update_config(self, value)
      end
    end

    #Create or update config for this model, based on the parent that owns the configuration and the key/ that we are passing
    def set_adhoc_config_value!(key, value, data_type='String')
      config = "UniversalAr::Config#{data_type.to_s.titleize}".classify.constantize.find_or_create_by(subject: self, key: key)
      config.update(value: value)
    end

    #find the relevant config entry and make sure they have entered one
    scope :with_config_value, ->(configuration){
      joins("INNER JOIN `#{configuration.config_class.table_name}` AS `#{configuration.config_class.table_name}_#{configuration.key.gsub('-','_')}` ON `#{configuration.config_class.table_name}_#{configuration.key.gsub('-','_')}`.`key`='#{configuration.key}'
        AND `#{configuration.config_class.table_name}_#{configuration.key.gsub('-','_')}`.`subject_id` = `#{self.table_name}`.`id` AND `#{configuration.config_class.table_name}_#{configuration.key.gsub('-','_')}`.`subject_type` = '#{self.class_name}'").
      where("`#{configuration.config_class.table_name}_#{configuration.key.gsub('-','_')}`.`value` IS NOT NULL AND `#{configuration.config_class.table_name}_#{configuration.key.gsub('-','_')}`.`value` <> ''")
    }

    #find the relevant config entry and make sure they have entered one
    scope :matching_config_value, ->(configuration, value){
      joins("INNER JOIN `#{configuration.config_class.table_name}` AS `#{configuration.config_class.table_name}_#{configuration.key.gsub('-','_')}` ON `#{configuration.config_class.table_name}_#{configuration.key.gsub('-','_')}`.`key`='#{configuration.key}'
        AND `#{configuration.config_class.table_name}_#{configuration.key.gsub('-','_')}`.`subject_id` = `#{self.table_name}`.`id` AND `#{configuration.config_class.table_name}_#{configuration.key.gsub('-','_')}`.`subject_type` = '#{self.class_name}'").
      where("`#{configuration.config_class.table_name}_#{configuration.key.gsub('-','_')}`.`value` = ?", value)
    }

    #find the relevant config entry and make sure they have entered one
    scope :like_config_value, ->(configuration, value){
      joins("INNER JOIN `#{configuration.config_class.table_name}` AS `#{configuration.config_class.table_name}_#{configuration.key.gsub('-','_')}` ON `#{configuration.config_class.table_name}_#{configuration.key.gsub('-','_')}`.`key`='#{configuration.key}'
        AND `#{configuration.config_class.table_name}_#{configuration.key.gsub('-','_')}`.`subject_id` = `#{self.table_name}`.`id` AND `#{configuration.config_class.table_name}_#{configuration.key.gsub('-','_')}`.`subject_type` = '#{self.class_name}'").
      where("`#{configuration.config_class.table_name}_#{configuration.key.gsub('-','_')}`.`value` LIKE ?", "%#{value}%")
    }

  end
end
