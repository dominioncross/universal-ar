class UniversalAr::ConfigInteger < ApplicationRecord
  self.table_name = 'config_integers'
  include UniversalAr::Concerns::Base
  include UniversalAr::Concerns::Polymorphic
  
  base UniversalAr::ConfigInteger, 'config_integers'
  
  belongs_to :configuration, optional: true
  
  validates :subject, :key, presence: true
  
end
  