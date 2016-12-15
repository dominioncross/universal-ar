class UniversalAr::SubjectFunction < ApplicationRecord
  self.table_name = 'subject_functions'
  include UniversalAr::Concerns::Polymorphic
  belongs_to :function
end
