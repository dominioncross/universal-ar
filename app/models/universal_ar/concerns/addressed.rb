# frozen_string_literal: true
module UniversalAr
  module Concerns
    module Addressed
      extend ActiveSupport::Concern
      included do

        has_many :addresses, as: :subject, class_name: 'UniversalAr::Address'

        def address=(address_hash)
          address_hash[:kind] ||= :default
          existing_address = addresses.for_kind(address_hash[:kind]).first
          if existing_address
            existing_address.update(address_hash)
          else
            existing_address = addresses.new address_hash.permit!
            existing_address.scope = scope
            existing_address.save
          end
          existing_address
        end

        def address(kind=nil)
          return @address if @address
          a = addresses
          a = a.for_kind(kind) if kind
          @address = a.first
        end

      end
    end
  end
end
