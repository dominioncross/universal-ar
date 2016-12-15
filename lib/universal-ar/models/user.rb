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
      
      base :user
      statuses %w(active archived)
      kinds %w(admin guest)
    end
  end
end