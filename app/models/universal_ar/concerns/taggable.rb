module UniversalAr::Concerns
  module Taggable
    extend ActiveSupport::Concern
    
    included do
      def tags
        self.key_values.where(key: :tag).map{|f| f.value.to_s}
      end
      def tagged_with?(tag)
        (self.tags.include?(tag.to_s.parameterize))
      end
      def tag!(tag)
        tag = tag.to_s.parameterize
        if !self.tags.include?(tag)
          self.key_values.create(key: :tag, value: tag)
        end
      end
      def remove_tag!(tag)
        self.key_values.where(key: :tag, value: tag.to_s).destroy_all
      end
    end
    
    module ClassMethods
      def tags(klass)
        scope :tagged, ->(value){joins("INNER Join key_values as tag_key_values on `tag_key_values`.`subject_id`=`#{klass}`.`id` and `tag_key_values`.`subject_type`='#{klass.to_s.classify}' and `tag_key_values`.`key` = 'tag'").where("tag_key_values.value IN (#{(value.class!=Array ? [value.to_s] : value).map{|v| "'#{v.to_s.parameterize}'"}.join(',')})").select("DISTINCT #{klass}.*")}
      end
    end
  end
end