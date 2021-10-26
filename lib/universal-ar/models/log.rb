module UniversalAr::Models
  module Log
    extend ActiveSupport::Concern

    included do
      self.table_name = 'logs'
      include UniversalAr::Concerns::Base
      include UniversalAr::Concerns::Scoped
      include UniversalAr::Concerns::Polymorphic

      base UniversalAr::Log, 'logs'

      belongs_to :user, optional: true

      validates :code, :subject, presence: true

      scope :priority, ->(){ where(priority: true) }
      scope :recent, ->() { where('created_at > ?', 1.week.ago) }
      default_scope ->(){ order(created_at: :desc) }

      def self.build(log_hash)
        log = UniversalAr::Log.new(log_hash)
        log.save
      end
    end
  end
end
