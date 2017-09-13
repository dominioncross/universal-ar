module UniversalAr
  module Concerns
    module Functional
      extend ActiveSupport::Concern
      
      included do
        has_many :subject_functions, as: :subject, class_name: 'UniversalAr::SubjectFunction'
        has_many :functions, through: :subject_functions, class_name: 'UniversalAr::Function'
      end
      
      #returns the functions as an array of strings
      def function_names
        self.functions.map{|f| f.name.to_s}
      end
      
      # checks whether the subject can/has access to the context and the function
      # eg. current_user.can?(:sysadmin, :manage_roles)
      # :sysadmin is the context/group of functions
      # :manage_roles is the function
      def can?(context, function_code=nil)
        if function_code.blank?
          return self.functions.map{|f| f.context}.include?(context.to_s)
        else
          return self.functions.map{|f| f.name}.include?("#{context.to_s}.#{function_code.to_s}")
        end
      end
      
      #alias for can?
      def has?(context, code=nil)
        can?(context, code=nil)
      end
      
    end
  end
end