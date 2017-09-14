class UniversalAr::Scope < ApplicationRecord
  self.table_name = 'scopes'
  include UniversalAr::Concerns::Base
  include UniversalAr::Concerns::Array
  include UniversalAr::Concerns::Functional
  include UniversalAr::Concerns::Commentable
  include UniversalAr::Concerns::HasRoles
  
  has_many :users, class_name: 'UniversalAr::User'
  
  base 'UniversalAr::Scope', 'scopes'
  array %w(domain)
  
end
