class UniversalAr::ConfigString < ApplicationRecord
  self.table_name = 'config_strings'
  include UniversalAr::Concerns::Base
  include UniversalAr::Concerns::Polymorphic
  
  base UniversalAr::ConfigString, 'config_strings'
  
  belongs_to :configuration, optional: true
  
  validates :subject, :key, presence: true
  
end
  