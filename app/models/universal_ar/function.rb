class UniversalAr::Function < ApplicationRecord
  self.table_name = 'functions'
  has_and_belongs_to_many :subject_functions, class_name: 'UniversalAr::SubjectFunction'
  
  def name
    [self.context, self.code].join('.')
  end
  
end
