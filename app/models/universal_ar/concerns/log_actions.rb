# frozen_string_literal: true

module UniversalAr::Concerns::LogActions
  extend ActiveSupport::Concern

  included do
    has_many :action_logs, as: :subject, class_name: 'UniversalAr::ActionLog'

    def log_action!(code, user)
      action_logs.create scope: scope, code: code, user: user
    end
  end

end
