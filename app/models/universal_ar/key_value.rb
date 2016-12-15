class UniversalAr::KeyValue < ApplicationRecord
  self.table_name = 'key_values'
  include UniversalAr::Concerns::Polymorphic
  
end
