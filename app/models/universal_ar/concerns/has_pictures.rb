module UniversalAr::Concerns::HasPictures
  extend ActiveSupport::Concern
  included do
    has_many :pictures, as: :subject, class_name: 'UniversalAr::Picture'
  end
end