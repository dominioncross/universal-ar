module UniversalAr::Concerns::Array
  
  extend ActiveSupport::Concern
  
  included do
  end
  
  module ClassMethods
    
    def array(array_keys=[])
      
      array_keys.each do |key|
        define_method key.pluralize do
          kv = self.key_values.where(key: key)
          return kv.map{|k| k.value}
        end
        define_method "add_#{key}!" do |v|
          if self.key_values.where(key: key, value: v).empty?
            self.key_values.create key: key, value: v
          end
        end
        define_method "remove_#{key}!" do |v|
          self.key_values.where(key: key, value: v).destroy_all
        end
        define_singleton_method "find_all_by_#{key.to_s}" do |v|
          "#{self.class_name}".constantize.joins("INNER JOIN `key_values` AS `#{key}_key_values`
            ON `#{key}_key_values`.`subject_type`='#{self.class_name.to_s}'
            AND `#{key}_key_values`.`subject_id`=`#{self.table_name}`.`id`
            AND `#{key}_key_values`.`key`='#{key}'")
            .where("`#{key}_key_values`.`value`=?", v)
        end
        define_singleton_method "find_by_#{key.to_s}" do |v|
          "#{self.class_name}".constantize.joins("INNER JOIN `key_values` AS `#{key}_key_values`
            ON `#{key}_key_values`.`subject_type`='#{self.class_name.to_s}'
            AND `#{key}_key_values`.`subject_id`=`#{self.table_name}`.`id`
            AND `#{key}_key_values`.`key`='#{key}'")
            .where("`#{key}_key_values`.`value`=?", v).first
        end
        
      end
      
      
    end
    
  end
  
end