class UniversalAr::Configuration < ApplicationRecord
  self.table_name = 'configurations'
  include UniversalAr::Concerns::Base
  include UniversalAr::Concerns::Polymorphic
  
  base UniversalAr::Configuration, 'configurations'
  
  has_many :config_booleans, class_name: 'UniversalAr::ConfigBoolean'
  has_many :config_dates, class_name: 'UniversalAr::ConfigDate'
  has_many :config_strings, class_name: 'UniversalAr::ConfigString'
  has_many :config_integers, class_name: 'UniversalAr::ConfigInteger'
  
  extend FriendlyId
  friendly_id :title, use: :scoped, scope: :subject, slug_column: :key
  
  validates :key, uniqueness: {scope: :subject}

  def config_class
    case self.data_type
    when 'String'
      return UniversalAr::ConfigString
    when 'Integer'
      return UniversalAr::ConfigInteger
    when 'Date'
      return UniversalAr::ConfigDate
    when 'Boolean'
      return UniversalAr::ConfigBoolean
    end
  end
  
  #find the value that has been saved for this subject model
  def config(subject)
    @self_config ||= self.config_class.find_by(subject: subject, key: self.key)
  end
  
  #find the value that has been saved for this subject model
  def config_value(subject)
    return nil if self.config(subject).nil?
    self.config(subject).value
  end
  
  def create_or_update_config(subject, value)
    existing = self.config(subject)
    if existing.nil?
      existing = self.config_class.create configuration: self, key: self.key, value: value, subject: subject
    else
      existing.update(value: value)
    end
  end
  
  

end
  