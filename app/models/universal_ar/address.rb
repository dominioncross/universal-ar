class UniversalAr::Address < ApplicationRecord
  self.table_name = 'addresses'
  include UniversalAr::Concerns::Base
  include UniversalAr::Concerns::Scoped
  include UniversalAr::Concerns::Kind
  include UniversalAr::Concerns::Polymorphic

  base UniversalAr::Address, 'addresses'
  kinds %w[default]

  validates :line_1, :city, :country, presence: true

end
