# frozen_string_literal: true

class UniversalAr::Log < ApplicationRecord
  self.table_name = 'logs'
  include UniversalAr::Concerns::Base
  include UniversalAr::Concerns::Scoped
  include UniversalAr::Concerns::Polymorphic

  base UniversalAr::Log, 'logs'

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

  def self.build(log_hash)
    log = UniversalAr::Log.new(log_hash)
    log.save
  end
end
