class UniversalAr::Configuration < ApplicationRecord
  self.table_name = 'configurations'
  include UniversalAr::Concerns::Base
  include UniversalAr::Concerns::Polymorphic
  
  base UniversalAr::Configuration, 'configurations'
  
  has_many :config_booleans, class_name: 'UniversalAr::ConfigBoolean'
  has_many :config_dates, class_name: 'UniversalAr::ConfigDate'
  has_many :config_strings, class_name: 'UniversalAr::ConfigString'
  has_many :config_integers, class_name: 'UniversalAr::ConfigInteger'
  
end
  