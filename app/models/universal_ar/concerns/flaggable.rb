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

        def flagged_with?(flag)
          self.flags.include?(flag.to_s.parameterize)
        end
      end

      module ClassMethods
        def flags(flag_array=[])
          join = "INNER Join key_values as flag_key_values on `flag_key_values`.`subject_id`=`#{self.table_name}`.`id` and `flag_key_values`.`subject_type`='#{self.class_name.to_s.classify}' and `flag_key_values`.`key` = 'flag'"
          const_set("Flags", flag_array.map{|a| a.to_s})

          flag_array.each do |name|

            define_method("#{name}?") do
              return self.flags.include?(name.to_s.parameterize)
            end

            #scopes
            scope name.to_s.parameterize, ->(){
              joins(join).where('flag_key_values.key=? and flag_key_values.value=?', :flag, name.to_s.parameterize)
            }
            scope "not_#{name}".to_sym, ->(){
              where("`#{self.table_name}`.`id` NOT IN
                (SELECT `flag_key_values`.`subject_id` FROM `key_values` AS `flag_key_values`
                  WHERE `flag_key_values`.`key` = 'flag' AND `flag_key_values`.`value` = '#{name}')
              ")
            }

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
