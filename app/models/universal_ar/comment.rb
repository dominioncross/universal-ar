class UniversalAr::Comment < ApplicationRecord
  self.table_name = 'comments'
  include UniversalAr::Concerns::Base
  include UniversalAr::Concerns::Status
  include UniversalAr::Concerns::Scoped
  include UniversalAr::Concerns::Kind
  include UniversalAr::Concerns::Polymorphic

  base UniversalAr::Comment, 'comments'
  kinds

  belongs_to :user, optional: true

  default_scope ->(){ order(created_at: :desc) }

end
