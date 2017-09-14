module UniversalAr::Concerns::HasRoles
  extend ActiveSupport::Concern
  included do
    has_many :roles, class_name: 'UniversalAr::Role', as: :scope
  end
end