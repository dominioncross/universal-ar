module UniversalAr::Models
  module User
    extend ActiveSupport::Concern

    included do
      devise :database_authenticatable, :registerable,
               :recoverable, :rememberable, :trackable, :validatable
      # Include default devise modules. Others available are:
      # :confirmable, :lockable, :timeoutable and :omniauthable

      include UniversalAr::Concerns::Base
      include UniversalAr::Concerns::Kind
      include UniversalAr::Concerns::Status
      include UniversalAr::Concerns::UserAccess
      include UniversalAr::Concerns::Scoped
      include UniversalAr::Concerns::Flaggable
      include UniversalAr::Concerns::Commentable
      include UniversalAr::Concerns::Logged
      include UniversalAr::Concerns::Taggable

      base 'User', 'users'
      statuses %w(active archived)
      kinds %w(admin guest)
      flags
      tags

      has_many :created_logs, class_name: 'UniversalAr::Log', foreign_key: :user_id

      def name
        [self.given_names.titleize, self.family_name.titleize].compact.join(' ')
      end

    end
  end
end
