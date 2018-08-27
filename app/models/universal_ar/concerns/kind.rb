# frozen_string_literal: true

module UniversalAr::Concerns
  module Kind
    extend ActiveSupport::Concern
    included do
      private

      def set_default_kind
        self.kind ||= default_kind.to_s
      end
    end

    module ClassMethods
      def kinds(kind_array = [], default_kind = nil)
        attr_accessor :default_kind
        const_set('Kinds', kind_array.map(&:to_s))

        before_create :set_default_kind
        scope :for_kind, ->(kind) { where(kind: kind.to_s) }

        unless default_kind.blank?
          after_initialize :init_kind
          define_method 'init_kind' do
            @default_kind ||= default_kind.to_s
          end
        end

        kind_array.each do |name|
          # pending?
          define_method("#{name}?") { read_attribute(:kind) == name.to_s }
          # scopes
          scope name.to_sym, ->() { where(kind: name.to_s) }
          scope "not_#{name}".to_sym, ->() { where('kind <> ?', name.to_s) }
        end
      end
    end
  end
end
