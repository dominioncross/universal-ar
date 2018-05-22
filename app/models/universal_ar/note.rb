# frozen_string_literal: true

class UniversalAr::Note < ApplicationRecord
  self.table_name = 'notes'
  include UniversalAr::Concerns::Base
  include UniversalAr::Concerns::Scoped
  include UniversalAr::Concerns::Kind
  include UniversalAr::Concerns::Status
  include UniversalAr::Concerns::Polymorphic

  base UniversalAr::Note, 'notes'

  belongs_to :user, optional: true

  validates :message, :subject, presence: true

  statuses %w[current archived], default: :current
  kinds %w[general system log], default: :general

  default_scope { order(id: :desc) }

  def json
    {
      id: id.to_s,
      kind: kind,
      status: status,
      message: message,
      date: created_at,
      user_id: user_id.to_s,
      user_name: user.nil? ? nil : user.name
    }
  end

  def self.build(note_hash)
    note = UniversalAr::Note.new(note_hash.except(:kind).except(:status))
    note.save
    note.kind = note_hash[:kind] if note_hash[:kind].present?
    note.status = note_hash[:status] if note_hash[:status].present?
  end
end
