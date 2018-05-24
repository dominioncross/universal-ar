# frozen_string_literal: true

module UniversalAr::Concerns::Logged
  extend ActiveSupport::Concern

  included do
    has_many :logs, as: :subject, class_name: 'UniversalAr::Log'

    def log!(code, user)
      logs.create scope: scope, code: code, user: user
    end
  end

end
