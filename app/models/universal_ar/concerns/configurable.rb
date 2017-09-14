module UniversalAr::Concerns::Configurable

  extend ActiveSupport::Concern

  included do
    
    has_many :configurations, class_name: 'UniversalAr::Configuration', as: :subject
    has_many :config_strings, class_name: 'UniversalAr::ConfigString', as: :subject
    has_many :config_integers, class_name: 'UniversalAr::ConfigInteger', as: :subject
    has_many :config_booleans, class_name: 'UniversalAr::ConfigBoolean', as: :subject
    has_many :config_dates, class_name: 'UniversalAr::ConfigDate', as: :subject

  end
end
