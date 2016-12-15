module UniversalAr
  module Concerns
    module Flaggable
      extend ActiveSupport::Concern
      
      included do
        
        def flags
          self.key_values.where(key: :flag).map{|f| f.value.to_s}
        end
        def flag!(flag)
          flag = flag.to_s.parameterize
          if !self.flags.include?(flag)
            self.key_values.create(key: :flag, value: flag)
          end
        end
        def remove_flag!(flag)
          self.key_values.where(key: :flag, value: flag.to_s).destroy_all
        end
      end
      
      module ClassMethods
        def flags(klass, flag_array=[])
          join = "INNER Join key_values as flag_key_values on `flag_key_values`.`subject_id`=`#{klass}`.`id` and `flag_key_values`.`subject_type`='#{klass.to_s.classify}' and `flag_key_values`.`key` = 'flag'"
          scope :flagged, ->(value){joins(join).where("flag_key_values.value IN (#{(value.class!=Array ? [value.to_s] : value).map{|v| "'#{v.to_s.parameterize}'"}.join(',')})").group("#{klass}.id")}
          const_set("Flags", flag_array.map{|a| a.to_s})
    
          flag_array.each do |name|
            
            define_method("#{name}?") do
              return self.flags.include?(name.to_s.parameterize)
            end
    
            #scopes
            scope name.to_s.parameterize, ->(){joins(join).where('flag_key_values.key=? and flag_key_values.value=?', :flag, name.to_s.parameterize)}
            scope "not_#{name}".to_sym, ->(){joins(join).where('flag_key_values.key=? and flag_key_values.value<>?', :flag, name.to_s.parameterize)}
    
            #eg: pending!, approved!
            define_method("#{name}!") do
              self.flag!(name)
            end
            
          end
    
        end
      end
      
    end
  end
end