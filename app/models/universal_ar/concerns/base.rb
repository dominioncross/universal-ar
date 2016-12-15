module UniversalAr::Concerns
  module Base
    extend ActiveSupport::Concern
    
    included do
      
      has_many :key_values, as: :subject, dependent: :destroy, class_name: 'UniversalAr::KeyValue'
      
    end
    
    module ClassMethods
      attr_accessor :klass
      
      def base(klass)
        @klass ||= klass.to_s
      end
      
    end
    
  end
end