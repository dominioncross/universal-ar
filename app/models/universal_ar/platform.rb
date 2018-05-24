class UniversalAr::Platform < ApplicationRecord
  self.table_name = 'platforms'
  include UniversalAr::Concerns::Base

  base UniversalAr::Platform, 'platforms'

  has_many :scopes, class_name: 'UniversalAr::Scope'

end
