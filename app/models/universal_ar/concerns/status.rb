# frozen_string_literal: true

module UniversalAr::Concerns
  module Status
    extend ActiveSupport::Concern
    included do
      private

      def set_default_status
        self.status ||= default_status.to_s
      end
    end

    module ClassMethods
      def statuses(status_array = [], default_status = nil)
        attr_accessor :default_status
        const_set('Statuses', status_array.map(&:to_s))

        before_create :set_default_status
        unless default_status.blank?
          after_initialize :init_status
          define_method 'init_status' do
            @default_status ||= default_status.to_s
          end
        end

        status_array.each do |name|
          # pending?
          define_method("#{name}?") { read_attribute(:status) == name.to_s }
          define_method("#{name}!") { update(status: name.to_s) }
          # scopes
          scope name.to_sym, ->() { where(status: name.to_s) }
          scope "not_#{name}".to_sym, ->() { where("`#{table_name}`.`status` <> ?", name.to_s) }
        end
      end
    end
  end
end
