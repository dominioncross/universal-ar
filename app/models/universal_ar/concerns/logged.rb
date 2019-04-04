# frozen_string_literal: true

module UniversalAr::Concerns::Logged
  extend ActiveSupport::Concern

  included do
    has_many :logs, as: :subject, class_name: 'UniversalAr::Log', dependent: :destroy

    def log!(code, user=nil, value=nil)
      logs.create scope: scope, code: code, user: user, value: value
    end

    def priority_log!(code, user=nil)
      logs.create scope: scope, code: code, user: user, priority: true
    end

    def logged_at(code, user=nil)
      l = logs.where(code: code)
      l = l.where(user: user) if user
      return unless l.any?

      l.first.created_at
    end

  end

end
