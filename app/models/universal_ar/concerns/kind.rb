module UniversalAr::Concerns
  module Kind
    extend ActiveSupport::Concern
    included do
      
      def kind=(val)
        key_value = self.key_values.find_or_create_by(key: :kind)
        key_value.update(value: val.to_s)
      end
      
      def kind
        key_value = self.key_values.find_by(key: :kind)
        key_value.value.to_s if !key_value.nil?
      end
      
      private
        def set_default_kind
          self.key_values.new key: :kind, value: self.default_kind.to_s
        end
    end
    
    module ClassMethods
      
      def kinds(kind_array=[], default_kind=nil)
        attr_accessor :default_kind
        join = "INNER Join key_values as kind_key_values on `kind_key_values`.`subject_id`=`#{self.table_name}`.`id` and
          `kind_key_values`.`subject_type`='#{self.class_name}' and `kind_key_values`.`key` = 'kind'"
        scope :for_kind, ->(value){joins(join).where('kind_key_values.value=?', value.to_s)}
        const_set("Kinds", kind_array.map{|a| a.to_s})
        before_create :set_default_kind

        if !default_kind.blank?
          after_initialize :init
          define_method "init" do
            @default_kind ||= default_kind.to_s
          end
        end
        
        kind_array.each do |name|
          #pending?
          define_method :kind do
            key_value = self.key_values.find_by(key: :kind)
            return key_value.nil? ? nil : key_value.value.to_s
          end
          define_method("#{name}?") do
            return self.kind == name.to_s
          end
          #scopes
          scope name.to_sym, ->(){where('kind=?', name.to_s)}
          scope "not_#{name}".to_sym, ->(){where('kind<>?', name.to_s)}
        end
      end
      
    end
  end
end