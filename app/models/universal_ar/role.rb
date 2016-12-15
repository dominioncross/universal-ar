class UniversalAr::Role < ApplicationRecord
  self.table_name = 'roles'
  has_and_belongs_to_many :users, join_table: :users_roles
  include UniversalAr::Concerns::Functional
end
