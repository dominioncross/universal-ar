# frozen_string_literal: true
module UniversalAr
  module Concerns
    module Numbered
      extend ActiveSupport::Concern
      included do
        after_create do
          UniversalAr::ReferenceNumber.generate(reference_number_scope, self)
        end

        def reference_number
          @reference_number ||= UniversalAr::ReferenceNumber.find_by  scope: reference_number_scope,
                                                                      subject_type: self.class,
                                                                      subject_id: id
        end

        def number
          return unless reference_number
          reference_number.number
        end

        def padded_number
          number.to_s.rjust(6, '0')
        end

        # overwrite in the scoped model
        def reference_number_prefix
          nil
        end

        def reference
          [reference_number_prefix, padded_number].compact.join('-').upcase
        end
      end
    end
  end
end
