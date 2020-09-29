class UniversalAr::ConfigBoolean < ApplicationRecord
  self.table_name = 'config_booleans'
  include UniversalAr::Concerns::Base
  include UniversalAr::Concerns::Polymorphic

  base UniversalAr::ConfigBoolean, 'config_booleans'

  belongs_to :configuration, optional: true

  validates :subject, :key, presence: true

end
