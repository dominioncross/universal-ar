module UniversalAr::Concerns
  module Base
    extend ActiveSupport::Concern
    
    included do
      
      has_many :key_values, as: :subject, dependent: :destroy, class_name: 'UniversalAr::KeyValue'
      
    end
    
    module ClassMethods
      attr_accessor :class_name
      attr_accessor :table_name
      
      def base(class_name, table_name)
        @class_name ||= class_name.to_s
        @table_name ||= table_name.to_s
      end
      
    end
    
  end
end