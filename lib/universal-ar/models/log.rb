module UniversalAr::Models
  module Log
    extend ActiveSupport::Concern

    included do
      self.table_name = 'logs'
      include UniversalAr::Concerns::Base
      include UniversalAr::Concerns::Scoped
      include UniversalAr::Concerns::Polymorphic

      base UniversalAr::Log, 'logs'

      belongs_to :user

      validates :code, :subject, presence: true

      default_scope ->(){ order(created_at: :desc) }

      def self.build(log_hash)
        log = UniversalAr::Log.new(log_hash)
        log.save
      end
    end
  end
end
