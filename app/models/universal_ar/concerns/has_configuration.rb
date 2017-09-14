module UniversalAr::Concerns::HasConfiguration

  extend ActiveSupport::Concern

  included do
    
    #allow configurations to be specified on this model, for child models of this model
    has_many :configurations, class_name: 'UniversalAr::Configuration', as: :subject
    

  end
end
