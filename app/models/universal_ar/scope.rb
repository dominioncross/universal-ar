class UniversalAr::Scope < ApplicationRecord
  self.table_name = 'scopes'
  include UniversalAr::Concerns::Base
  include UniversalAr::Concerns::Array
  include UniversalAr::Concerns::Functional
  
  has_many :roles, class_name: 'UniversalAr::Role'
  has_many :users, class_name: 'UniversalAr::User'
  
  base :scope
  array %w(domain)
  
end
