class UniversalAr::Role < ApplicationRecord
  self.table_name = 'roles'
  include UniversalAr::Concerns::Base
  include UniversalAr::Concerns::Functional
  include UniversalAr::Concerns::Scoped
  include UniversalAr::Concerns::Flaggable
  
  has_and_belongs_to_many :users, join_table: :users_roles
  
  base 'UniversalAr::Role', 'roles'
  flags %w(locked)
  
end
