module UniversalAr::Concerns::HasAttachments
  extend ActiveSupport::Concern
  included do
    has_many :attachments, as: :subject, class_name: 'UniversalAr::Attachment'
  end
end