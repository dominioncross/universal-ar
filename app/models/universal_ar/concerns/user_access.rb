module UniversalAr
  module Concerns
    module UserAccess
      extend ActiveSupport::Concern
      included do
        has_and_belongs_to_many :roles, join_table: :users_roles, class_name: 'UniversalAr::Role'
        has_many :role_functions, through: :roles, source: :functions, class_name: 'UniversalAr::Function'
        
        def role_names
          self.roles.map{|r| r.name}
        end
        
        def role_function_names
          self.role_functions.uniq.map{|r| r.name}
        end
        
        def can?(context, code=nil)
          if code.blank?
            return self.role_functions.map{|f| f.context}.include?(context.to_s)
          else
            return self.role_functions.map{|f| f.name}.include?("#{context.to_s}.#{code.to_s}")
          end
        end
        
      end
      
    end
  end
end