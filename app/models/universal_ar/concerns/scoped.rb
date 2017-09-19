module UniversalAr::Concerns::Scoped
  extend ActiveSupport::Concern
  included do
    prepare_scope
  end
  
  module ClassMethods
    def prepare_scope
      belongs_to :scope, polymorphic: true, optional: true
      scope :scoped_to, ->(model){where(scope_id: (model.nil? ? nil : model.id), scope_type: (model.nil? ? nil : model.class.to_s))}
    end
  end
  
end