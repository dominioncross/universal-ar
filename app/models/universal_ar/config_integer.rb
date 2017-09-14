class UniversalAr::ConfigInteger < ApplicationRecord
  self.table_name = 'config_integers'
  include UniversalAr::Concerns::Base
  include UniversalAr::Concerns::Polymorphic
  
  base UniversalAr::ConfigInteger, 'config_integers'
  
  belongs_to :configuration
  
  validates :subject, :key, :value, presence: true
  
end
  