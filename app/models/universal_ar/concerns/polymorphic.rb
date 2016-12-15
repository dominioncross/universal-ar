module UniversalAr::Concerns::Polymorphic
  extend ActiveSupport::Concern
  
  included do
    belongs_to :subject, polymorphic: true
  end
  
end