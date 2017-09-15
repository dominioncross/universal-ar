module UniversalAr
  module Concerns
    module Status
      extend ActiveSupport::Concern
      
      included do
            
        def status=(val)
          key_value = self.key_values.find_or_create_by(key: :status)
          key_value.update(value: val.to_s)
        end
        
        def status
          key_value = self.key_values.find_by(key: :status)
          key_value.value.to_s if !key_value.nil?
        end
        
        private
        def set_default_status
          self.key_values.new key: :status, value: self.default_status.to_s
        end
      end
      
      module ClassMethods
        #possible options: :default (symbol), :multiple (true/false)
        def statuses(status_array=[], options={})
          attr_accessor :default_status
          join = "INNER Join key_values as status_key_values on `status_key_values`.`subject_id`=`#{self.table_name}`.`id` and 
            `status_key_values`.`subject_type`='#{self.class_name}' and `status_key_values`.`key` = 'status'"
          scope :for_status, ->(value){joins(join).where('status_key_values.value=?', value.to_s)}
          const_set("Statuses", status_array.map{|a| a.to_s})
          before_create :set_default_status
            
          if !options[:default].blank?
            after_initialize :init
            define_method "init" do
              @default_status ||= options[:default].to_s
            end
          end
    
          status_array.each do |name|
            if name.to_s.downcase == 'new'
              raise "Error: You cannot have a status named 'new'. Please change the 'statuses' declaration in the #{self} Class."
            elsif name.to_s.downcase == 'valid'
              raise "Error: You cannot have a status named 'valid'. Please change the 'statuses' declaration in the #{self} Class."
            end
    
            #pending?
            define_method :status do
              key_value = self.key_values.find_by(key: :status)
              return key_value.nil? ? nil : key_value.value.to_s
            end
            define_method("#{name}?") do
              return self.status == name.to_s
            end
    
            #scopes
            scope name.to_sym, ->(){joins(join).where('status_key_values.value=?', name.to_s)}
            scope "not_#{name}".to_sym, ->(){joins(join).where('status_key_values.value<>?', name.to_s)}
    
            #This will record the current status, as well as the status history that this model has been through
            if options[:multiple]
              scope "been_#{name}".to_sym, ->(){where('_ss.s' => name.to_s)}
              #model.been_pending? - Checks the status history to see if this is in there.
              define_method("been_#{name}?") { self.read_attribute(:_ss).select{|s| s['s'].to_s == name.to_s}.length>0 }
              
              define_method :status_history do
                self.key_value_histories
              end
            end
            #eg: pending!, approved!
            define_method("#{name}!") do
              #find the key_value and update it
              key_value = self.key_values.find_by(key: :status)
              was_value = key_value.nil? ? nil : key_value.value
              if key_value.nil?
                self.key_values.create(key: :status, value: status.to_s)
              else
                key_value.update(value: name.to_s)
              end
              if options[:multiple]
                self.key_value_histories.create key: :status, was_value: was_value, now_value: name.to_s
              end
            end
            
          end
    
        end
      end
      
    end
  end
end