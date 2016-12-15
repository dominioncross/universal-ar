module UniversalAr
  module Concerns
    module Functional
      extend ActiveSupport::Concern
      
      included do
        has_many :subject_functions, as: :subject, class_name: 'UniversalAr::SubjectFunction'
        has_many :functions, through: :subject_functions, class_name: 'UniversalAr::Function'
      end
      
      def can?(context, code=nil)
        if code.blank?
          return self.functions.map{|f| f.context}.include?(context.to_s)
        else
          return self.functions.map{|f| f.name}.include?("#{context.to_s}.#{code.to_s}")
        end
      end
      
      def has?(context, code=nil)
        can?(context, code=nil)
      end
      
    end
  end
end