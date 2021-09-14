class UniversalAr::Scope < ApplicationRecord
  self.table_name = 'scopes'
  include UniversalAr::Concerns::Base
  include UniversalAr::Concerns::Array
  include UniversalAr::Concerns::Functional
  include UniversalAr::Concerns::Commentable
  include UniversalAr::Concerns::HasRoles
  include UniversalAr::Concerns::Logged
  include UniversalAr::Concerns::Configurable

  has_and_belongs_to_many :users, class_name: 'User'

  base UniversalAr::Scope, 'scopes'
  array %w(domain)

  belongs_to :platform, optional: true

  after_initialize do
    self.guid = SecureRandom.uuid if new_record?
  end
end
