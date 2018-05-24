# frozen_string_literal: true

class UniversalAr::ActionLog < ApplicationRecord
  self.table_name = 'action_logs'
  include UniversalAr::Concerns::Base
  include UniversalAr::Concerns::Scoped
  include UniversalAr::Concerns::Polymorphic

  base UniversalAr::ActionLog, 'action_logs'

  belongs_to :user

  validates :code, :subject, presence: true

  def json
    {
      id: id.to_s,
      code: code,
      date: created_at,
      user_id: user_id.to_s,
      user_name: user.nil? ? nil : user.name
    }
  end

  def self.build(action_log_hash)
    action_log = UniversalAr::ActionLog.new(action_log_hash)
    action_log.save
  end
end
