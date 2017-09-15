class UniversalAr::ConfigDate < ApplicationRecord
  self.table_name = 'config_dates'
  include UniversalAr::Concerns::Base
  include UniversalAr::Concerns::Polymorphic
  
  base UniversalAr::ConfigDate, 'config_dates'
  
  belongs_to :configuration
  
  validates :subject, :key, presence: true
  
end
  