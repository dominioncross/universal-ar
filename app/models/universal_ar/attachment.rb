class UniversalAr::Attachment < ApplicationRecord
  self.table_name = 'attachments'
  include UniversalAr::Concerns::Base
  include UniversalAr::Concerns::Scoped
  include UniversalAr::Concerns::Kind
  include UniversalAr::Concerns::Polymorphic
  include UniversalAr::Concerns::Commentable
  include UniversalAr::Concerns::Taggable
  
  base UniversalAr::Attachment, 'attachments'
  kinds
  tags
        
  mount_uploader :file, UniversalAr::FileUploader
        
  validates_presence_of :file
  scope :for_name, ->(n){where(name: n)}
  scope :recent, ->(){order_by(created_at: :desc)}
  
  belongs_to :user
  
  def image?
    %w(.png .jpg .gif).any?{ |file_type| self.file_identifier.to_s.include?(file_type) }
  end
  
  def title
    self.name.blank? ? self.file_identifier : self.name
  end
        
  def to_json
    {
      id: self.id.to_s,
      title: self.title,
      filename: self.file_identifier,
      url: self.file.url,
      created_at: self.created_at,
      scope_type: self.scope_type,
      scope_id: self.scope_id,
      subject_type: self.subject_type,
      subject_id: self.subject_id,
      subject_name: self.subject.name,
      created_formatted: self.created_at.strftime('%b %d, %Y'),
      image: self.image?
    }
  end
end
