# frozen_string_literal: true

module UniversalAr::Concerns::HasNotes
  extend ActiveSupport::Concern

  included do
    has_many :notes, as: :subject, class_name: 'UniversalAr::Note'

    UniversalAr::Note::Kinds.each do |kind|
      define_method("#{kind}_note!") do |message, user = nil, scope = nil|
        scope ||= self.scope
        UniversalAr::Note.build subject: self,
                                kind: kind,
                                message: message,
                                user: user,
                                scope: scope
      end
    end
  end

  def note!(message, user = nil, scope = nil, kind = nil)
    scope ||= self.scope
    UniversalAr::Note.build subject: self,
                            message: message,
                            user: user,
                            scope: scope,
                            kind: kind
  end
end
